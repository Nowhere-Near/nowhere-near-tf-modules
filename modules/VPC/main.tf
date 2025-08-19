data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = length(var.azs) > 0 ? var.azs : data.aws_availability_zones.available.names

  # Build keyed maps for for_each
  public_subnets = var.create_public_subnets ? {
    for idx, cidr in var.public_subnet_cidrs :
    format("%s-public-%02d", var.name, idx + 1) => {
      cidr = cidr
      az   = local.azs[idx % length(local.azs)]
      name = format("%s-public-%s", var.name, local.azs[idx % length(local.azs)])
    }
  } : {}

  private_subnets = var.create_private_subnets ? {
    for idx, cidr in var.private_subnet_cidrs :
    format("%s-private-%02d", var.name, idx + 1) => {
      cidr = cidr
      az   = local.azs[idx % length(local.azs)]
      name = format("%s-private-%s", var.name, local.azs[idx % length(local.azs)])
    }
  } : {}
}

resource "aws_vpc" "this" {
  count                = var.is_create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = merge(var.tags, {
    Name = var.name
  })
}

# Use created or provided VPC ID
locals {
  vpc_id = var.is_create_vpc ? aws_vpc.this[0].id : var.vpc_id
}

# Internet Gateway (only if asked and we have public subnets)
resource "aws_internet_gateway" "this" {
  count  = var.create_igw && length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = local.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name}-igw"
  })
}

# ---------- PUBLIC SUBNETS ----------
resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = local.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(var.tags, var.public_subnet_tags, {
    Name = each.value.name
    Tier = "public"
  })
}

resource "aws_route_table" "public" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = local.vpc_id

  tags = merge(var.tags, var.route_table_tags, {
    Name = "${var.name}-public-rt"
    Tier = "public"
  })
}

# Default route to Internet via IGW
resource "aws_route" "public_internet_gateway" {
  count                  = var.create_igw && length(local.public_subnets) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[0].id
}

# ---------- PRIVATE SUBNETS ----------
resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = local.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, var.private_subnet_tags, {
    Name = each.value.name
    Tier = "private"
  })
}

resource "aws_route_table" "private" {
  count  = length(local.private_subnets) > 0 ? 1 : 0
  vpc_id = local.vpc_id

  tags = merge(var.tags, var.route_table_tags, {
    Name = "${var.name}-private-rt"
    Tier = "private"
  })
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[0].id
}

# ---------- OPTIONAL: Single NAT Gateway for private egress ----------
# Create only if: asked for NAT, AND have both private and public subnets.
resource "aws_eip" "nat" {
  count  = var.create_nat_gateway && length(local.private_subnets) > 0 && length(local.public_subnets) > 0 ? 1 : 0
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.name}-nat-eip"
  })
}

resource "aws_nat_gateway" "this" {
  count         = var.create_nat_gateway && length(local.private_subnets) > 0 && length(local.public_subnets) > 0 ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  # Place NAT in the lexicographically-first public subnet for determinism
  subnet_id = aws_subnet.public[sort(keys(aws_subnet.public))[0]].id

  tags = merge(var.tags, {
    Name = "${var.name}-nat"
  })
}

resource "aws_route" "private_to_nat" {
  count                  = var.create_nat_gateway && length(local.private_subnets) > 0 ? 1 : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

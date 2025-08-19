output "vpc_id" {
  value       = local.vpc_id
  description = "VPC ID (created or provided)"
}

output "vpc_arn" {
  description = "VPC ARN (null if using existing)"
  value       = var.is_create_vpc ? aws_vpc.this[0].arn : null
}

output "vpc_cidr" {
  value       = var.is_create_vpc ? aws_vpc.this[0].cidr_block : null
  description = "VPC CIDR (null if using existing)"
}

output "igw_id" {
  value       = try(aws_internet_gateway.this[0].id, null)
  description = "Internet Gateway ID"
}

output "public_subnet_ids" {
  value       = [for s in values(aws_subnet.public) : s.id]
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = [for s in values(aws_subnet.private) : s.id]
  description = "List of private subnet IDs"
}

output "public_route_table_id" {
  value       = try(aws_route_table.public[0].id, null)
  description = "Public route table ID"
}

output "private_route_table_id" {
  value       = try(aws_route_table.private[0].id, null)
  description = "Private route table ID"
}

output "nat_gateway_id" {
  value       = try(aws_nat_gateway.this[0].id, null)
  description = "NAT Gateway ID (if created)"
}

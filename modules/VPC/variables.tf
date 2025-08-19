variable "name" {
  description = "Base name used for tagging and naming"
  type        = string
}

variable "is_create_vpc" {
  description = "Whether to create the VPC in this module"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "Use an existing VPC ID when is_create_vpc = false"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR for the VPC (only used when is_create_vpc = true)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "VPC instance tenancy"
  type        = string
  default     = "default"
}

variable "azs" {
  description = "Availability Zones to place subnets in. If empty, all available AZs are used."
  type        = list(string)
  default     = []
}

variable "create_public_subnets" {
  type    = bool
  default = true
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets; mapped round-robin across AZs"
  type        = list(string)
  default     = []
}

variable "create_private_subnets" {
  type    = bool
  default = false
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets; mapped round-robin across AZs"
  type        = list(string)
  default     = []
}

variable "create_igw" {
  description = "Create an Internet Gateway (used by public route table default route)"
  type        = bool
  default     = true
}

variable "create_nat_gateway" {
  description = "Create a single NAT Gateway in the first public subnet and route private subnets through it"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Only single-NAT is supported in this version"
  type        = bool
  default     = true
  validation {
    condition     = var.single_nat_gateway
    error_message = "This version supports only single NAT Gateway (single_nat_gateway must be true)."
  }
}

variable "tags" {
  description = "Base tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets"
  type        = map(string)
  default     = {}
}

variable "route_table_tags" {
  description = "Additional tags for route tables"
  type        = map(string)
  default     = {}
}

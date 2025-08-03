variable "region" {
  description = "AWS region"
  default     = "af-south-1"
}

variable "efs_tags" {
  description = "Tags for the EBS volume"
  type        = map(string)
}

variable "efs_creation_token" {
  description = "A unique name for the EBS volume"
  type        = string
}

variable "subnet_ids" {
  description = "The ID of the subnet to add the EBS volume to"
  type        = set(string)
}


variable "security_group_id" {
  description = "The ID of the security group to add the EBS volume to"
  type        = string
}

variable "availability_zone_name" {
  description = "The name of the availability zone"
  type        = string
}

variable "efs_policy" {
  description = "The policy for the EFS file system"
  type        = string

}

variable "vpc_id" {
  description = "The ID of the VPC endpoint to add the EFS volume to"
  type        = string
}

variable "efs_performance_mode" {
  description = "The performance mode of the EFS file system"
  type        = string
  default     = "generalPurpose"

}

variable "pvt_dns" {
  description = "Enable private DNS for the VPC endpoint"
  type        = bool
  default     = true
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "af-south-1"
}

variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 8
}

variable "ebs_volume_type" {
  description = "Type of the EBS volume"
  type        = string
  default     = "gp3"
}


variable "ecr_tags" {
  description = "Tags for the EBS volume"
  type        = map(string)
}

variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "Image tag mutability for the ECR repository"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_repository_policy" {
  description = "Policy for the ECR repository"
  type        = string
  default     = ""
}
variable "ami_owners" {
  description = "List of AWS account IDs that own the AMIs to search for."
  type        = list(string)
  default     = ["amazon"]
}

variable "ami_filters" {
  description = "Filters to apply when searching for AMIs."
  type        = map(list(string))
  default     = {}

}

variable "ec2_name" {
  description = "Prefix for naming EC2."
  type        = string
}

variable "vpc_subnet_id" {
  description = "The ID of the VPC subnet to launch the EC2 instance in."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance."
  type        = set(string)
}

variable "instance_type" {
  description = "The type of instance to launch."
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB."
  type        = number
  default     = 8
}

variable "ebs_optimized" {
  description = "Whether to enable EBS optimization for the instance."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the EC2 instance."
  type        = map(string)
}

variable "user_data_base64" {
  description = "Base64 encoded user data script to run on instance launch."
  type        = string
  default     = ""

}

variable "public_eip" {
  description = "Public Elastic IP to associate with the EC2 instance."
  type        = string
  default     = ""

}

variable "iam_instance_profile" {
  description = "IAM instance profile to associate with the EC2 instance."
  type        = string
}

variable "isEIP" {
  description = "Flag to indicate if an Elastic IP should be associated with the EC2 instance"
  type        = bool
  default     = false
}
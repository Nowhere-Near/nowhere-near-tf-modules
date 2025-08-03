variable "region" {
  description = "AWS region"
  type        = string
  default     = "af-south-1"
}

variable "s3_tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
}

variable "bucket_name" {
  description = "A unique name for Jenkins"
  type        = string
}

variable "s3_bucket_policy_actions" {
  description = "Actions for the S3 bucket policy"
  type        = set(string)
  default     = ["s3:GetObject", "s3:PutObject"]
}

variable "s3_policy_principal_type" {
  description = "The principal type for the S3 bucket policy"
  type        = string
  default     = "AWS"
}


variable "s3_versioning_value" {
  description = "The versioning status of the S3 bucket"
  type        = string
  default     = "Enabled"
}

variable "web_index_document" {
  description = "The index document for the S3 bucket"
  type        = string
  default     = "index.html"
}

variable "web_error_document" {
  description = "The error document for the S3 bucket"
  type        = string
  default     = "error.html"
}

variable "cors_allowed_headers" {
  description = "Allowed headers for the S3 bucket"
  type        = set(string)
  default     = ["*"]

}

variable "cors_allowed_methods" {
  description = "Allowed methods for the S3 bucket"
  type        = set(string)
  default     = ["GET", "PUT", "POST", "DELETE"]
}

variable "cors_allowed_origins" {
  description = "Allowed origins for the S3 bucket"
  type        = set(string)
  default     = ["*"]
}

variable "cors_max_age_seconds" {
  description = "The maximum age for the S3 bucket"
  type        = number
  default     = 2000
}

variable "bucket_policy" {
  description = "The policy for the S3 bucket"
  type        = string
  default     = null

}



/*
=========================================================================================================
=========================================================================================================
Boolean variables that act as flags to determine the creation of the S3 bucket, access point, and policy
*/

variable "is_existing_bucket" {
  description = "Use an existing S3 bucket"
  type        = bool
  default     = false
}


variable "is_policy" {
  description = "Create a policy for the S3 bucket"
  type        = bool
  default     = false
}

variable "is_public" {
  description = "Make the S3 bucket public"
  type        = bool
  default     = false
}

variable "is_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "is_website" {
  description = "Enable website hosting for the S3 bucket"
  type        = bool
  default     = false

}

variable "is_cors" {
  description = "Enable CORS for the S3 bucket"
  type        = bool
  default     = false
}
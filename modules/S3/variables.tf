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

variable "cors_expose_headers" {
  description = "Exposed headers for the S3 bucket"
  type        = set(string)
  default     = ["ETag"]

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

# Creation behavior
variable "force_destroy" {
  description = "Force destroy the S3 bucket, even if it contains objects"
  type        = bool
  default     = false
}

# Ownership controls
variable "set_object_ownership" {
  description = "Set object ownership for the S3 bucket"
  type        = bool
  default     = true
}
variable "object_ownership" {
  type    = string
  default = "BucketOwnerEnforced"
  validation {
    condition     = contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "Invalid object_ownership."
  }
}

# Public access block (secure defaults; relax for public website)
variable "enable_public_access_block" {
  description = "Enable public access block for the S3 bucket"
  type        = bool
  default     = true

}
variable "block_public_acls" {
  description = "Block public ACLs for the S3 bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public policies for the S3 bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs for the S3 bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets for the S3 bucket"
  type        = bool
  default     = true
}

# Default encryption
variable "enable_sse" {
  description = "Enable server-side encryption for the S3 bucket"
  type        = bool
  default     = true
}
variable "sse_algorithm" {
  description = "The server-side encryption algorithm for the S3 bucket"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "KMS key ID for server-side encryption (if using aws:kms)"
  type        = string
  default     = null
}

variable "sse_bucket_key_enabled" {
  description = "Enable bucket key for server-side encryption"
  type        = bool
  default     = true
}

# Lifecycle (data-driven)
variable "lifecycle_rules" {
  description = "List of lifecycle rules for the S3 bucket"
  # id, status=("Enabled"|"Disabled")
  # filter: { prefix=string, tags=map(string) }
  # transition: { days=number, storage_class=string }
  # expiration: { days=number }
  # noncurrent_version_expiration: { noncurrent_days=number }
  # abort_incomplete_multipart_upload: { days_after_initiation=number }
  type = list(object({
    id                                = string
    status                            = string
    filter                            = optional(object({ prefix = optional(string), tags = optional(map(string)) }))
    transition                        = optional(object({ days = optional(number), storage_class = optional(string) }))
    expiration                        = optional(object({ days = optional(number) }))
    noncurrent_version_expiration     = optional(object({ noncurrent_days = optional(number) }))
    abort_incomplete_multipart_upload = optional(object({ days_after_initiation = optional(number) }))
  }))
  default = []
}

# CORS
variable "cors_rules" {
  description = "CORS rules for the S3 bucket"
  type = list(object({
    allowed_headers = optional(list(string))
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}
# (keep your existing single-rule vars for backwards compatibility)

# Website routing rules (optional)
variable "web_routing_rules" {
  description = "Website routing rules for the S3 bucket"
  type = list(object({
    condition = optional(object({ key_prefix_equals = optional(string) }))
    redirect = object({
      replace_key_prefix_with = optional(string)
      host_name               = optional(string)
      protocol                = optional(string)
      http_redirect_code      = optional(string)
    })
  }))
  default = []
}

# Access logging
variable "enable_access_logging" {
  description = "Enable access logging for the S3 bucket"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "Target bucket for access logs"
  type        = string
  default     = null
}

variable "logging_target_prefix" {
  description = "Prefix for the access log files in the target bucket"
  type        = string
  default     = null
}

variable "s3_bucket_policy" {
  description = "The policy for the S3 bucket"
  type        = string
  default     = null
}

variable "s3_versioning_value" {
  type    = string
  default = "Enabled"
  validation {
    condition     = contains(["Enabled", "Suspended"], var.s3_versioning_value)
    error_message = "s3_versioning_value must be Enabled or Suspended."
  }
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
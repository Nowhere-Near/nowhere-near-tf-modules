variable "region" {
  description = "The AWS region to deploy the CloudFront distribution"
  type        = string
  default     = "us-east-1"
}

variable "cf_distrivution_s3_bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket to be used as the CloudFront distribution origin"
  type        = string
}

variable "cf_origin_access_id_comment" {
  description = "The comment of the CloudFront origin access identity"
  type        = string
}

variable "cf_distribution_aliases" {
  description = "The aliases of the CloudFront distribution"
  type        = set(string)
}

variable "acm_cert_domain" {
  description = "The domain of the ACM certificate to be used for the CloudFront distribution"
  type        = string
  default     = "nowhere-near.net"
}

variable "cf_distribution_comment" {
  description = "The comment of the CloudFront distribution"
  type        = string
}

variable "cf_distribution_enabled" {
  description = "Whether the CloudFront distribution is enabled"
  type        = bool
  default     = true
}

variable "cf_distribution_cached_methods" {
  description = "The cached methods of the CloudFront distribution"
  type        = set(string)
  default     = ["GET", "HEAD"]
}

variable "cf_distribution_cache_allowed_methods" {
  description = "The allowed methods of the CloudFront distribution cache"
  type        = set(string)
  default     = ["GET", "HEAD", "POST"]
}

variable "cf_distribution_default_root_object" {
  description = "The default root object of the CloudFront distribution"
  type        = string
  default     = "index.html"
}

variable "s3_origin_id" {
  description = "S3 Origin Id Passed in"
  type        = string
  default     = "s3-origin"
}

variable "default_cache_behavior_target_origin_id" {
  description = "The target origin ID for the default cache behavior"
  type        = string
  default     = "s3-origin"
}

variable "default_cache_behavior_viewer_protocol_policy" {
  description = "The viewer protocol policy for the default cache behavior"
  type        = string
  default     = "redirect-to-https"

}

variable "tags" {
  description = "The tags to apply to the CloudFront distribution"
  type        = map(string)
}
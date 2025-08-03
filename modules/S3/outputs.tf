output "bucket_name" {
  description = "value of the S3 bucket name"
  value       = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].bucket : aws_s3_bucket.bucket[0].bucket
}

output "bucket_arn" {
  description = "value of the S3 bucket ARN"
  value       = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].arn : aws_s3_bucket.bucket[0].arn
}

output "bucket_regional_domain_name" {
  description = "value of the S3 bucket regional domain name"
  value       = aws_s3_bucket_website_configuration.s3_website[0].website_endpoint
}
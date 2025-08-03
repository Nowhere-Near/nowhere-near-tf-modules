output "cf_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "cf_distributions_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.arn
}

output "cf_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cf_distribution_etag" {
  description = "The current version of the CloudFront distribution's information"
  value       = aws_cloudfront_distribution.s3_distribution.etag
}

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate used for the CloudFront distribution"
  value       = data.aws_acm_certificate.nowhere_near_site_cert.arn
  sensitive   = true
}

output "cf_origin_access_id" {
  description = "The ID of the CloudFront origin access identity"
  value       = aws_cloudfront_origin_access_identity.cf_origin_access_id.id
}
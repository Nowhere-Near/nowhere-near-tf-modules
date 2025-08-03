data "aws_acm_certificate" "nowhere_near_site_cert" {
  domain = var.acm_cert_domain
}

resource "aws_cloudfront_origin_access_identity" "cf_origin_access_id" {
  comment = var.cf_origin_access_id_comment
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.cf_distrivution_s3_bucket_regional_domain_name
    origin_id   = var.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_origin_access_id.cloudfront_access_identity_path
    }
  }

  enabled             = var.cf_distribution_enabled
  comment             = var.cf_distribution_comment
  default_root_object = var.cf_distribution_default_root_object

  aliases = var.cf_distribution_aliases

  default_cache_behavior {
    allowed_methods  = var.cf_distribution_cache_allowed_methods
    cached_methods   = var.cf_distribution_cached_methods
    target_origin_id = var.default_cache_behavior_target_origin_id


    viewer_protocol_policy = var.default_cache_behavior_viewer_protocol_policy
    min_ttl                = 0
    default_ttl            = 2200
    max_ttl                = 8640

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }


  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.nowhere_near_site_cert.arn
    cloudfront_default_certificate = false
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }
}
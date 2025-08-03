resource "aws_s3_bucket" "bucket" {
  count  = var.is_existing_bucket ? 0 : 1
  bucket = var.bucket_name
  tags   = var.s3_tags
}

data "aws_s3_bucket" "bucket" {
  count  = var.is_existing_bucket ? 1 : 0
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count  = var.is_versioning ? 1 : 0
  bucket = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].bucket : aws_s3_bucket.bucket[0].bucket
  versioning_configuration {
    status = var.s3_versioning_value
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.is_policy ? 1 : 0
  bucket = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].bucket : aws_s3_bucket.bucket[0].bucket
  policy = var.bucket_policy
}

resource "aws_s3_bucket_cors_configuration" "cors_config" {
  count  = var.is_cors ? 1 : 0
  bucket = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].bucket : aws_s3_bucket.bucket[0].bucket
  cors_rule {
    allowed_headers = var.cors_allowed_headers
    allowed_methods = var.cors_allowed_methods
    allowed_origins = var.cors_allowed_origins
    max_age_seconds = var.cors_max_age_seconds
  }

}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  count  = var.is_website ? 1 : 0
  bucket = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].bucket : aws_s3_bucket.bucket[0].bucket
  index_document {
    suffix = var.web_index_document
  }
  error_document {
    key = var.web_error_document
  }
}

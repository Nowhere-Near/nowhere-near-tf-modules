# ---- Canonical bucket (create vs existing) ----
resource "aws_s3_bucket" "bucket" {
  count         = var.is_existing_bucket ? 0 : 1
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = var.s3_tags
}

data "aws_s3_bucket" "bucket" {
  count  = var.is_existing_bucket ? 1 : 0
  bucket = var.bucket_name
}

# Single source of truth for refs
locals {
  bucket_id   = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].id : aws_s3_bucket.bucket[0].id
  bucket_name = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].bucket : aws_s3_bucket.bucket[0].bucket
  bucket_arn  = var.is_existing_bucket ? data.aws_s3_bucket.bucket[0].arn : aws_s3_bucket.bucket[0].arn
}

# ---- Recommended controls ----
resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.set_object_ownership ? 1 : 0
  bucket = local.bucket_id
  rule {
    object_ownership = var.object_ownership # "BucketOwnerEnforced" (default), "BucketOwnerPreferred", "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.enable_public_access_block ? 1 : 0
  bucket = local.bucket_id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enable_sse ? 1 : 0
  bucket = local.bucket_id
  rule {
    bucket_key_enabled = var.sse_bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm # "AES256" or "aws:kms"
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_key_id : null
    }
  }
}

# ---- Versioning (as you had, using unified ref) ----
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count  = var.is_versioning ? 1 : 0
  bucket = local.bucket_id
  versioning_configuration { status = var.s3_versioning_value } # "Enabled" or "Suspended"
}

# ---- Lifecycle (modern resource + data-driven rules) ----
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = local.bucket_id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      dynamic "filter" {
        for_each = [true]
        content {
          prefix = try(rule.value.filter.prefix, null)
          dynamic "tag" {
            for_each = try(rule.value.filter.tags, {})
            content {
              key   = tag.key
              value = tag.value
            }
          }
        }
      }

      dynamic "transition" {
        for_each = try([rule.value.transition], [])
        content {
          days          = try(transition.value.days, null)
          storage_class = try(transition.value.storage_class, null)
        }
      }

      dynamic "expiration" {
        for_each = try([rule.value.expiration], [])
        content { days = try(expiration.value.days, null) }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = try([rule.value.noncurrent_version_expiration], [])
        content { noncurrent_days = try(noncurrent_version_expiration.value.noncurrent_days, null) }
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = try([rule.value.abort_incomplete_multipart_upload], [])
        content { days_after_initiation = try(abort_incomplete_multipart_upload.value.days_after_initiation, null) }
      }
    }
  }
}

# ---- CORS (multi-rule; falls back to your single-rule vars) ----
resource "aws_s3_bucket_cors_configuration" "cors_config" {
  count  = var.is_cors || length(var.cors_rules) > 0 ? 1 : 0
  bucket = local.bucket_id

  dynamic "cors_rule" {
    for_each = length(var.cors_rules) > 0 ? var.cors_rules : [
      {
        allowed_headers = var.cors_allowed_headers
        allowed_methods = var.cors_allowed_methods
        allowed_origins = var.cors_allowed_origins
        expose_headers  = var.cors_expose_headers
        max_age_seconds = var.cors_max_age_seconds
      }
    ]
    content {
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}

# ---- Website (unchanged, uses unified ref; added optional routing rules) ----
resource "aws_s3_bucket_website_configuration" "s3_website" {
  count  = var.is_website ? 1 : 0
  bucket = local.bucket_id

  index_document { suffix = var.web_index_document }

  dynamic "error_document" {
    for_each = var.web_error_document != "" ? [1] : []
    content { key = var.web_error_document }
  }

  dynamic "routing_rule" {
    for_each = var.web_routing_rules
    content {
      condition { key_prefix_equals = try(routing_rule.value.condition.key_prefix_equals, null) }
      redirect {
        replace_key_prefix_with = try(routing_rule.value.redirect.replace_key_prefix_with, null)
        host_name               = try(routing_rule.value.redirect.host_name, null)
        protocol                = try(routing_rule.value.redirect.protocol, null)
        http_redirect_code      = try(routing_rule.value.redirect.http_redirect_code, null)
      }
    }
  }
}

# ---- Access logging (optional) ----
resource "aws_s3_bucket_logging" "this" {
  count         = var.enable_access_logging ? 1 : 0
  bucket        = local.bucket_id
  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = (var.is_policy) ? 1 : 0
  bucket = local.bucket_id
  policy = var.s3_bucket_policy
}

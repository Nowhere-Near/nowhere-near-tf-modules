## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_cors_configuration.cors_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.s3_website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | A unique name for Jenkins | `string` | n/a | yes |
| <a name="input_s3_tags"></a> [s3\_tags](#input\_s3\_tags) | Tags for the S3 bucket | `map(string)` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | The policy for the S3 bucket | `string` | `null` | no |
| <a name="input_cors_allowed_headers"></a> [cors\_allowed\_headers](#input\_cors\_allowed\_headers) | Allowed headers for the S3 bucket | `set(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_cors_allowed_methods"></a> [cors\_allowed\_methods](#input\_cors\_allowed\_methods) | Allowed methods for the S3 bucket | `set(string)` | <pre>[<br>  "GET",<br>  "PUT",<br>  "POST",<br>  "DELETE"<br>]</pre> | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | Allowed origins for the S3 bucket | `set(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_cors_max_age_seconds"></a> [cors\_max\_age\_seconds](#input\_cors\_max\_age\_seconds) | The maximum age for the S3 bucket | `number` | `2000` | no |
| <a name="input_is_cors"></a> [is\_cors](#input\_is\_cors) | Enable CORS for the S3 bucket | `bool` | `false` | no |
| <a name="input_is_existing_bucket"></a> [is\_existing\_bucket](#input\_is\_existing\_bucket) | Use an existing S3 bucket | `bool` | `false` | no |
| <a name="input_is_policy"></a> [is\_policy](#input\_is\_policy) | Create a policy for the S3 bucket | `bool` | `false` | no |
| <a name="input_is_public"></a> [is\_public](#input\_is\_public) | Make the S3 bucket public | `bool` | `false` | no |
| <a name="input_is_versioning"></a> [is\_versioning](#input\_is\_versioning) | Enable versioning for the S3 bucket | `bool` | `false` | no |
| <a name="input_is_website"></a> [is\_website](#input\_is\_website) | Enable website hosting for the S3 bucket | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"af-south-1"` | no |
| <a name="input_s3_bucket_policy_actions"></a> [s3\_bucket\_policy\_actions](#input\_s3\_bucket\_policy\_actions) | Actions for the S3 bucket policy | `set(string)` | <pre>[<br>  "s3:GetObject",<br>  "s3:PutObject"<br>]</pre> | no |
| <a name="input_s3_policy_principal_type"></a> [s3\_policy\_principal\_type](#input\_s3\_policy\_principal\_type) | The principal type for the S3 bucket policy | `string` | `"AWS"` | no |
| <a name="input_s3_versioning_value"></a> [s3\_versioning\_value](#input\_s3\_versioning\_value) | The versioning status of the S3 bucket | `string` | `"Enabled"` | no |
| <a name="input_web_error_document"></a> [web\_error\_document](#input\_web\_error\_document) | The error document for the S3 bucket | `string` | `"error.html"` | no |
| <a name="input_web_index_document"></a> [web\_index\_document](#input\_web\_index\_document) | The index document for the S3 bucket | `string` | `"index.html"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | value of the S3 bucket ARN |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | value of the S3 bucket name |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | value of the S3 bucket regional domain name |

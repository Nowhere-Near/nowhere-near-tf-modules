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
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.cf_origin_access_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_acm_certificate.nowhere_near_site_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cf_distribution_aliases"></a> [cf\_distribution\_aliases](#input\_cf\_distribution\_aliases) | The aliases of the CloudFront distribution | `set(string)` | n/a | yes |
| <a name="input_cf_distribution_comment"></a> [cf\_distribution\_comment](#input\_cf\_distribution\_comment) | The comment of the CloudFront distribution | `string` | n/a | yes |
| <a name="input_cf_distrivution_s3_bucket_regional_domain_name"></a> [cf\_distrivution\_s3\_bucket\_regional\_domain\_name](#input\_cf\_distrivution\_s3\_bucket\_regional\_domain\_name) | The regional domain name of the S3 bucket to be used as the CloudFront distribution origin | `string` | n/a | yes |
| <a name="input_cf_origin_access_id_comment"></a> [cf\_origin\_access\_id\_comment](#input\_cf\_origin\_access\_id\_comment) | The comment of the CloudFront origin access identity | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to the CloudFront distribution | `map(string)` | n/a | yes |
| <a name="input_acm_cert_domain"></a> [acm\_cert\_domain](#input\_acm\_cert\_domain) | The domain of the ACM certificate to be used for the CloudFront distribution | `string` | `"nowhere-near.net"` | no |
| <a name="input_cf_distribution_cache_allowed_methods"></a> [cf\_distribution\_cache\_allowed\_methods](#input\_cf\_distribution\_cache\_allowed\_methods) | The allowed methods of the CloudFront distribution cache | `set(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "POST"<br>]</pre> | no |
| <a name="input_cf_distribution_cached_methods"></a> [cf\_distribution\_cached\_methods](#input\_cf\_distribution\_cached\_methods) | The cached methods of the CloudFront distribution | `set(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_cf_distribution_default_root_object"></a> [cf\_distribution\_default\_root\_object](#input\_cf\_distribution\_default\_root\_object) | The default root object of the CloudFront distribution | `string` | `"index.html"` | no |
| <a name="input_cf_distribution_enabled"></a> [cf\_distribution\_enabled](#input\_cf\_distribution\_enabled) | Whether the CloudFront distribution is enabled | `bool` | `true` | no |
| <a name="input_default_cache_behavior_target_origin_id"></a> [default\_cache\_behavior\_target\_origin\_id](#input\_default\_cache\_behavior\_target\_origin\_id) | The target origin ID for the default cache behavior | `string` | `"s3-origin"` | no |
| <a name="input_default_cache_behavior_viewer_protocol_policy"></a> [default\_cache\_behavior\_viewer\_protocol\_policy](#input\_default\_cache\_behavior\_viewer\_protocol\_policy) | The viewer protocol policy for the default cache behavior | `string` | `"redirect-to-https"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy the CloudFront distribution | `string` | `"us-east-1"` | no |
| <a name="input_s3_origin_id"></a> [s3\_origin\_id](#input\_s3\_origin\_id) | S3 Origin Id Passed in | `string` | `"s3-origin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the ACM certificate used for the CloudFront distribution |
| <a name="output_cf_distribution_domain_name"></a> [cf\_distribution\_domain\_name](#output\_cf\_distribution\_domain\_name) | The domain name of the CloudFront distribution |
| <a name="output_cf_distribution_etag"></a> [cf\_distribution\_etag](#output\_cf\_distribution\_etag) | The current version of the CloudFront distribution's information |
| <a name="output_cf_distribution_id"></a> [cf\_distribution\_id](#output\_cf\_distribution\_id) | The ID of the CloudFront distribution |
| <a name="output_cf_distributions_arn"></a> [cf\_distributions\_arn](#output\_cf\_distributions\_arn) | The ARN of the CloudFront distribution |
| <a name="output_cf_origin_access_id"></a> [cf\_origin\_access\_id](#output\_cf\_origin\_access\_id) | The ID of the CloudFront origin access identity |

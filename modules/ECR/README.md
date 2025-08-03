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
| [aws_ecr_repository.my_ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_name"></a> [ecr\_name](#input\_ecr\_name) | Name of the ECR repository | `string` | n/a | yes |
| <a name="input_ecr_tags"></a> [ecr\_tags](#input\_ecr\_tags) | Tags for the EBS volume | `map(string)` | n/a | yes |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | Size of the EBS volume in GB | `number` | `8` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | Type of the EBS volume | `string` | `"gp3"` | no |
| <a name="input_ecr_image_tag_mutability"></a> [ecr\_image\_tag\_mutability](#input\_ecr\_image\_tag\_mutability) | Image tag mutability for the ECR repository | `string` | `"MUTABLE"` | no |
| <a name="input_ecr_repository_policy"></a> [ecr\_repository\_policy](#input\_ecr\_repository\_policy) | Policy for the ECR repository | `string` | `"value"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"af-south-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_arn"></a> [ecr\_arn](#output\_ecr\_arn) | value of the ECR repository ARN |
| <a name="output_ecr_name"></a> [ecr\_name](#output\_ecr\_name) | value of the ECR repository name |
| <a name="output_ecr_registry_id"></a> [ecr\_registry\_id](#output\_ecr\_registry\_id) | value of the ECR repository registry ID |

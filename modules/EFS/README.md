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
| [aws_efs_access_point.efs_access_point](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_file_system_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system_policy) | resource |
| [aws_efs_mount_target.efs_mount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone_name"></a> [availability\_zone\_name](#input\_availability\_zone\_name) | The name of the availability zone | `string` | n/a | yes |
| <a name="input_efs_creation_token"></a> [efs\_creation\_token](#input\_efs\_creation\_token) | A unique name for the EBS volume | `string` | n/a | yes |
| <a name="input_efs_policy"></a> [efs\_policy](#input\_efs\_policy) | The policy for the EFS file system | `string` | n/a | yes |
| <a name="input_efs_tags"></a> [efs\_tags](#input\_efs\_tags) | Tags for the EBS volume | `map(string)` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The ID of the security group to add the EBS volume to | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The ID of the subnet to add the EBS volume to | `set(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC endpoint to add the EFS volume to | `string` | n/a | yes |
| <a name="input_efs_performance_mode"></a> [efs\_performance\_mode](#input\_efs\_performance\_mode) | The performance mode of the EFS file system | `string` | `"generalPurpose"` | no |
| <a name="input_pvt_dns"></a> [pvt\_dns](#input\_pvt\_dns) | Enable private DNS for the VPC endpoint | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"af-south-1"` | no |

## Outputs

No outputs.

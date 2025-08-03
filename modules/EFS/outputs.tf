output "efs_name" {
  description = "value of the EFS name"
  value       = aws_efs_file_system.efs.id
}

output "efs_arn" {
  description = "value of the EFS ARN"
  value       = aws_efs_file_system.efs.arn
}

output "efs_id" {
  description = "value of the EFS ID"
  value       = aws_efs_file_system.efs.id
}

output "efs_ap_id" {
  description = "value of the EFS mount ID"
  value       = aws_efs_access_point.efs_access_point.id
}

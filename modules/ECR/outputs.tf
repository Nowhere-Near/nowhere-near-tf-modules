output "ecr_name" {
  description = "value of the ECR repository name"
  value       = aws_ecr_repository.my_ecr_repository.name
}

output "ecr_arn" {
  description = "value of the ECR repository ARN"
  value       = aws_ecr_repository.my_ecr_repository.arn
}

output "ecr_registry_id" {
  description = "value of the ECR repository registry ID"
  value       = aws_ecr_repository.my_ecr_repository.registry_id
}
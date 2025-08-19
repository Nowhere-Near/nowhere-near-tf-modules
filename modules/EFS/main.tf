resource "aws_efs_file_system" "efs" {
  creation_token   = var.efs_creation_token
  performance_mode = var.efs_performance_mode

  tags = var.efs_tags
}

resource "aws_efs_mount_target" "efs_mount" {
  for_each        = var.subnet_ids
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = [var.security_group_id]
}

resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.efs.id
  tags           = var.efs_tags
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id
  policy         = var.efs_policy # pass in the policy as a string
}

resource "aws_efs_backup_policy" "policy" {
  count          = var.is_efs_backup_enabled ? 1 : 0
  file_system_id = aws_efs_file_system.efs.id
  backup_policy {
    status = var.backup_policy_status
  }


}
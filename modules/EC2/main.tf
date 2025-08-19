locals {
  instance_name = "${var.ec2_name}-server"
}

data "aws_ami" "found_ami" {
  most_recent = true
  owners      = var.ami_owners

  dynamic "filter" {
    for_each = {
      for key, value in var.ami_filters :
      key => value
    }

    content {
      name   = filter.key
      values = filter.value
    }
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.found_ami.id
  subnet_id              = var.vpc_subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_instance_profile

  root_block_device {
    encrypted   = true
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  ebs_optimized = var.ebs_optimized

  user_data_base64 = var.user_data_base64

  tags = merge(
    var.tags,
    {
      Name = local.instance_name
    }
  )
  volume_tags = merge(
    var.tags,
    {
      Name = local.instance_name
    }
  )
}

# associate eip for resources
data "aws_eip" "ec2_instance_eip" {
  count     = var.isEIP ? 1 : 0
  public_ip = var.public_eip
}

resource "aws_eip_association" "my_eip_association" {
  count         = var.isEIP ? 1 : 0
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = data.aws_eip.ec2_instance_eip[0].id
}
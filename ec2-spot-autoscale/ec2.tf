data "aws_ami" "ami" {
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  owners      = ["amazon"]
  most_recent = true
}

resource "aws_launch_template" "scale" {
  name = "ec2-spot-autoscale"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  ebs_optimized = true

  image_id = data.aws_ami.ami.id

  instance_initiated_shutdown_behavior = "terminate"

  key_name = "mbp17"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.sg.id]

  #user_data = base64gzip(file("${path.module}/cloud-init.cfg")) # Use this compression for larger configs
  user_data = base64gzip(file("${path.module}/cloud-init.cfg"))
}

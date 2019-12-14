provider "aws" {
  region=var.region
}

resource "aws_launch_configuration" "asg-config" {
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups=["${aws_security_group.asg-sg.name}"]

  user_data = file("start-app.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "asg-sg" {
  name = var.asg_sg_name

  dynamic "ingress" {
    for_each = var.asg_sg_ingress
      content {
        from_port=ingress.value.from_port
        to_port=ingress.value.to_port
        protocol=ingress.value.protocol
        cidr_blocks=ingress.value.cidr_blocks
      }
  }

  dynamic "egress" {
    for_each = var.asg_sg_egress
      content {
        from_port=egress.value.from_port
        to_port=egress.value.to_port
        protocol=egress.value.protocol
        cidr_blocks=egress.value.cidr_blocks
      }
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "test-asg" {
  launch_configuration    = aws_launch_configuration.asg-config.id
  availability_zones      = data.aws_availability_zones.all.names
  health_check_type       = "EC2"
  min_size                = 1
  desired_capacity        = 2
  max_size                = 3

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "my-terraform-asg-example"
  }

  lifecycle {
    create_before_destroy = true
  }
}
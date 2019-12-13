provider "aws" {
    region=var.region
}

resource "aws_launch_configuration" "asg-config" {
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups=["${aws_security_group.asg-sg.name}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "asg-sg" {
  name = var.ssh_conection_name
  dynamic "ingress" {
    for_each = var.ssh_conection_ingress
      content {
        from_port=ingress.value.from_port
        to_port=ingress.value.to_port
        protocol=ingress.value.protocol
        cidr_blocks=ingress.value.cidr_blocks
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
  health_check_type       = "ELB"
  min_size                = 1
  desired_capacity        = 2
  max_size                = 3

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "my-terraform-asg-example"
  }
}
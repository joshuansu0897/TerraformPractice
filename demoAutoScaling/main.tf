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

## Security Group for aws_launch_configuration and EC2
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
  health_check_type       = "ELB"
  min_size                = var.min_size
  desired_capacity        = var.desired_capacity
  max_size                = var.max_size
  load_balancers = ["${aws_elb.example_elb.name}"]

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "my-terraform-asg-example"
  }

  lifecycle {
    create_before_destroy = true
  }
}

## Security Group for ELB
resource "aws_security_group" "elb_sg" {
  name = var.elb_sg_name

  dynamic "ingress" {
    for_each = var.elb_sg_ingress
    content {
      from_port=ingress.value.from_port
      to_port=ingress.value.to_port
      protocol=ingress.value.protocol
      cidr_blocks=ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.elb_sg_egress
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

### Creating ELB
resource "aws_elb" "example_elb" {
  name = var.name_elb
  security_groups = ["${aws_security_group.elb_sg.id}"]
  availability_zones = data.aws_availability_zones.all.names
  
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}

output "elb_dns_name" {
  value = "${aws_elb.example_elb.dns_name}"
}
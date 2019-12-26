### Public ASG - START
## ASG Config
resource "aws_launch_configuration" "asg_config_public" {
  image_id                    = data.aws_ami.latest_ubuntu.image_id
  instance_type               = var.instance_type
  security_groups             = ["${aws_security_group.public_sg.id}"]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key_access.key_name

  user_data = file("start-app.sh")

  lifecycle {
    create_before_destroy = true
  }
}

## ASG
resource "aws_autoscaling_group" "asg_public" {
  launch_configuration = aws_launch_configuration.asg_config_public.id
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  vpc_zone_identifier  = aws_subnet.public_subnets.*.id
  load_balancers       = ["${aws_elb.public_elb.name}"]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "my-terraform-asg-example-public"
  }

  lifecycle {
    create_before_destroy = true
  }
}

## ELB
resource "aws_elb" "public_elb" {
  name            = var.public_elb_name
  security_groups = ["${aws_security_group.public_sg.id}"]
  subnets         = aws_subnet.public_subnets.*.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

## Security Group
resource "aws_security_group" "public_sg" {
  name   = var.public_sg_name
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.public_sg_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.public_sg_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "elb_dns_name_public" {
  value = "${aws_elb.public_elb.dns_name}"
}
### Public ASG - END
### Private ASG - START
## ASG Config
resource "aws_launch_configuration" "asg_config_private" {
  image_id        = data.aws_ami.latest_ubuntu.image_id
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.private_sg.id}"]
  key_name        = aws_key_pair.key_access.key_name

  user_data = file("start-app.sh")

  lifecycle {
    create_before_destroy = true
  }
}

## ASG
resource "aws_autoscaling_group" "asg_private" {
  launch_configuration = aws_launch_configuration.asg_config_private.id
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  vpc_zone_identifier  = aws_subnet.private_subnets.*.id
  load_balancers       = ["${aws_elb.private_elb.name}"]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "my-terraform-asg-example-private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

## ELB
resource "aws_elb" "private_elb" {
  name            = var.private_elb_name
  security_groups = ["${aws_security_group.private_sg.id}"]
  subnets         = aws_subnet.private_subnets.*.id
  internal        = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

## Security Group
resource "aws_security_group" "private_sg" {
  name   = var.private_sg_name
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.private_sg_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.private_sg_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "elb_dns_name_private" {
  value = "${aws_elb.private_elb.dns_name}"
}
### Private ASG - END

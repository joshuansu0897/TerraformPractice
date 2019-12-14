variable "ami_id" {
  description = "Ami ID"
}

variable "instance_type" {
  description = "Instance type EC2 AWS"
}

variable "region" {
  description = "Region on AWS to Deploy"
}

variable "asg_sg_name" {
  description = "Is the name of aws_launch_configuration"
}

variable "asg_sg_ingress" {
  description = "Ingress Rules to aws_launch_configuration"
}

variable "asg_sg_egress" {
  description = "Egress Rules to aws_launch_configuration"
}
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

variable "elb_sg_name" {
  description = "Is the name of security groups of aws_elb"
}

variable "elb_sg_ingress" {
  description = "Ingress Rules to aws_elb"
}

variable "elb_sg_egress" {
  description = "Egress Rules to aws_elb"
}

variable "name_elb" {
  description = "Is the name of aws_elb"
}

variable "min_size" {
  description = "min_size of instances on aws_launch_configuration"
}

variable "desired_capacity" {
  description = "desired_capacity of instances on aws_launch_configuration"
}

variable "max_size" {
  description = "max_size of instances on aws_launch_configuration"
}
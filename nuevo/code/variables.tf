variable "instance_type" {
  #type = "string"
  description = "Instance type EC2 AWS"
}

variable "region" {
  #type = "string"
  description = "Region on AWS to Deploy"
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

variable "vpc_cidr" {
  #type = "string"
  description = "CIDR for the VPC"
}

variable "cidr_block_all" {
  #type = "string"
  description = "CIDR for all internet"
}

variable "public_subnet_cidrs" {
  #type = "list"
  description = "CIDRs for the public subnets"
}

variable "private_subnet_cidrs" {
  #type = "list"
  description = "CIDRs for the private subnets"
}

variable "public_sg_name" {
  #type = "string"
  description = "Is the name of security groups of public_subnet"
}

variable "public_sg_ingress" {
  #type = "list"
  description = "Ingress Rules to public_subnet"
}

variable "public_sg_egress" {
  #type = "list"
  description = "Egress Rules to public_subnet"
}

variable "public_elb_name" {
  #type = "string"
  description = "Is the name of security groups of public_subnet"
}

variable "private_sg_name" {
  #type = "string"
  description = "Is the name of security groups of private_subnet"
}

variable "private_sg_ingress" {
  #type = "list"
  description = "Ingress Rules to private_subnet"
}

variable "private_sg_egress" {
  #type = "list"
  description = "Egress Rules to public_subnet"
}

variable "private_elb_name" {
  #type = "string"
  description = "Is the name of security groups of private_subnet"
}

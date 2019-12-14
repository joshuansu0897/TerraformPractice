variable "ami_id" {
  description = "Ami ID"
}

variable "instance_type" {
  description = "Instance type EC2 AWS"
}

variable "tags" {
  description = "tags object"
}

variable "region" {
  description = "Region on AWS to Deploy"
}

variable "ssh_conection_name" {
  description = "Is the name of ssh_conection"
}

variable "ssh_conection_ingress" {
  description = "Ingress Rules to ssh_conection"
}

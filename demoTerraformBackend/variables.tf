variable "bucket_name" {
  default="backend-terraform-demo"
  description = "Name of S3 Bucket"
}

variable "acl" {
  default="private"
  description = "Instance type EC2 AWS"
}

variable "region" {
  default="us-east-2"
  description = "Region on AWS to Deploy"
}

variable "tags" {
  default={
    Enviroment="Dev",
    CreateBy="terraform"
  }
  description = "tags object"
}

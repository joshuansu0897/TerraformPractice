terraform {
  backend "s3" {
    bucket = "backend-terraform-demo"
    key    = "backend"
    region = "us-east-2"
    encrypt=true
    kms_key_id="output.arn"
  }
}
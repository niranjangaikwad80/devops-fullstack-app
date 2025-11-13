terraform {
  backend "s3" {
    bucket = "techverito-demo-s3"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    region = "ap-northeast-1"
    bucket = "pj-terraform-tfstate"
    key    = "pj/terraform.tfstate"
  }
}

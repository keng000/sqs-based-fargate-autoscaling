provider "aws" {
  version = "~> 2.5"
  region  = var.region[terraform.workspace]
}

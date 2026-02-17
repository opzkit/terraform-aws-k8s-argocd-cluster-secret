terraform {
  required_providers {
    kops = {
      source  = "terraform-kops/kops"
      version = ">= 1.31"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  required_version = ">= 1.9.0"
}

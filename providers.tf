terraform {
  required_providers {
    kops = {
      source  = "eddycharly/kops"
      version = "~>1.22"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.9.0"
}

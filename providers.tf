terraform {
  required_providers {
    kops = {
      source  = "eddycharly/kops"
      version = "~>1.22"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

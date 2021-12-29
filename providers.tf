terraform {
  required_providers {
    kops = {
      source  = "eddycharly/kops"
      version = "~>1.21"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

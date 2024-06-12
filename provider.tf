terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"            # means any version equal & above
    }
  }
}

provider "aws" {
  # Configuration options
  access_key = ""
  secret_key = ""
  region = var.region
}
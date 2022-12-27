terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.42.1"
    }
  }
  required_version = ">=1.3"
}
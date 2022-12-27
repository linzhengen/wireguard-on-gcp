terraform {
  #  backend "gcs" {
  #    bucket = "gcs-bucket-name"
  #    prefix = "tf/state/vpn"
  #  }
  backend "local" {
    path = "terraform.tfstate"
  }
}
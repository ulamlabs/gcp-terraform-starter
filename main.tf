locals {
  main_region = "us-west2"
  project = "examplecom"
}

provider "google" {
  project     = local.project
  region      = local.main_region
}


# just for a future mayself:
# this part should be added at the end when KMS/state bucket/IAM bucket permissions
# are already created
terraform {
  backend "gcs" {
    bucket  = "terraform-state-examplecom"
    prefix  = "/"
  }
}

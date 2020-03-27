provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

module "tf-back-prod-bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "tf-back-prod"
  stage       = "prod"
  location    = "europe-west1"
}

module "tf-back-stage-bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "tf-back-stage"
  stage       = "stage"
  location    = "europe-west1"
}

output tf-back-prod-bucket-url {
  value = module.tf-back-prod-bucket.url
}

output tf-back-stage-bucket-url {
  value = module.tf-back-stage-bucket.url
}
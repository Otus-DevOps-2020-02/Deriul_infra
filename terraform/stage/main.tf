terraform {
  backend "gcs" {
    bucket = "stage-tf-back-stage"
  }
}

provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

module "app" {
  source = "../modules/app"
}

module "db" {
  source = "../modules/db"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = var.source_ranges
}


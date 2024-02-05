terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google      = ">= 4.6.0"
    google-beta = ">= 4.6.0"
  }
}

provider "google" {
  project = var.project-id
  region  = "us-east1"
}

provider "google-beta" {
  project = var.project-id
  region  = "us-east1"
}

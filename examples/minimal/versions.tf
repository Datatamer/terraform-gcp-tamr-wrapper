terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google      = "~> 3.29.0"
    google-beta = "~> 3.29.0"
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

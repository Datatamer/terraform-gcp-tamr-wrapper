terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.29.0"
    }
    google-beta = {
      source  = "hashicorp/google"
      version = "~> 3.29.0"
    }
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

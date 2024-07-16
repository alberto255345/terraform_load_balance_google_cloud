provider "google" {
  credentials = file("<path-to-your-service-account-key>.json")
  project     = "trabalho-uece"
  region      = "us-central1" # Replace with your desired region
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

# Optionally, you can add a backend configuration if you are using a remote backend.
# terraform {
#   backend "gcs" {
#     bucket = "your-bucket-name"
#     prefix = "terraform/state"
#   }
# }

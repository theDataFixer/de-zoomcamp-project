terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
}

# Optional just to test project
resource "google_bigquery_dataset" "dataset" {
  dataset_id           = "example_dataset"
  project              = var.project
  location             = var.region
}

resource "google_bigquery_table" "example_table" {
  dataset_id           = google_bigquery_dataset.dataset.dataset_id
  table_id             = "ephemeral_table"
  description          = "A table for testing purposes"
  deletion_protection  = false

  schema = <<EOF
[
  {
    "name": "name",
    "type": "STRING"
  },
  {
    "name": "age",
    "type": "INTEGER"
  }
]
EOF
}

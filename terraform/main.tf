terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_storage_bucket" "mage-emi" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  location = var.location
  delete_contents_on_destroy = true
}


# Este código es compatible con Terraform 4.25.0 y versiones compatibles con 4.25.0.
# Para obtener información sobre la validación de este código de Terraform, consulta https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

# resource "google_compute_instance" "de-zoomcamp" {
#   boot_disk {
#     auto_delete = true
#     device_name = "de-zoomcamp"
# 
#     initialize_params {
#       image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240110"
#       size  = 30
#       type  = "pd-balanced"
#     }
# 
#     mode = "READ_WRITE"
#   }
# 
#   can_ip_forward      = false
#   deletion_protection = false
#   enable_display      = false
# 
#   labels = {
#     goog-ec-src = "vm_add-tf"
#   }
# 
#   machine_type = "e2-standard-4"
#   name         = "de-zoomcamp"
# 
#   network_interface {
#     access_config {
#       network_tier = "PREMIUM"
#     }
# 
#     queue_count = 0
#     stack_type  = "IPV4_ONLY"
#     subnetwork  = "projects/terraform-demo-emi/regions/us-south1/subnetworks/default"
#   }
# 
#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#     preemptible         = false
#     provisioning_model  = "STANDARD"
#   }
# 
#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot          = false
#     enable_vtpm                 = true
#   }
#   
#   metadata = {
#         ssh-keys = "emilel:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcmkWNPssO0Zq+E6SOJW+5T1sT0ldacG8nkAQcEXsW3cs8AaRfQoODfHeSVAtBEm6XAiJZ3d4Qc4myEfK3HoJxD9gRRZEvXnMi5mgFiVN2N/ZgniO1rw4gEgQm+IHQcwfwCfekGc3uoxhbBFa3h0wM9gFsGG2RlGRRuDih5JwJOOHlHOCTkeWJoQasO2/Yeyt7Y22KqDqoCHZba40pc0tCAjQ/uRttjgWxsrR3L7HZPnYffQdU0wx2ULxazkEw/bQqNLmT31HmR2kVQYqg9CvRGH8Sk38xk03kwS4ZEzJPXxWne2WcAi2q0Lj1Kbh5TVWNeVOT/tnBi9mob0R38lwF emilel"
#     }
# 
#   zone = "us-south1-a"
# }


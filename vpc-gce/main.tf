provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "terraform-subnetwork"
  ip_cidr_range = var.ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  
  # gcloud compute images list
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size = "10"
      type = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
    access_config {
    }
  }
}




locals {
  vm_name = "haley-instance"
}

resource "google_service_account" "haley_service_account" {
  account_id   = local.vm_name
  display_name = local.vm_name
}

resource "google_compute_subnetwork" "us_east1" {
  name          = "us-east1"
  ip_cidr_range = "10.20.0.0/20"
  network       = "${var.network_self_link}"
  region        = "us-east1"
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  purpose                    = "PRIVATE"
  stack_type                 = "IPV4_ONLY"
}

resource "google_compute_router" "nat_router_us_east1" {
  name    = "nat-router-us-east1"
  network = "${var.network_self_link}"
  region  = "us-east1"
}

resource "google_compute_router_nat" "nat_gateway_us-east1" {
  name                               = "nat-gateway-us-east1"
  router                             = google_compute_router.nat_router_us_east1.name
  region                             = "us-east1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_instance" "haley_instance" {
  
  name = local.vm_name
  machine_type = "e2-medium"
  zone = "us-east1-b"
  deletion_protection = false
  
  boot_disk {
    auto_delete = true
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 25
      type  = "pd-ssd"
    }

  }

  labels = {
    ansible_host = ""
  }

  metadata = {
    block-project-ssh-keys = "true",
    ssh-keys = format("%s", var.ssh_pub_cert)
  }

  network_interface {
    network     = "${var.network_self_link}"
    stack_type  = "IPV4_ONLY"
    subnetwork  = "${google_compute_subnetwork.us_east1.name}"
  }

  service_account {
    email  = format("%s@%s.iam.gserviceaccount.com",local.vm_name, var.project_id)
    scopes = ["cloud-platform"]
  }
}
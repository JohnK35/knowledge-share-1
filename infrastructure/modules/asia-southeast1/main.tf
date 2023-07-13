locals {
  vm_name = "abigail-instance"
}

resource "google_service_account" "abigail_service_account" {
  account_id   = local.vm_name
  display_name = local.vm_name
}

resource "google_compute_subnetwork" "asia_southeast1" {
  name          = "asia-southeast1"
  ip_cidr_range = "10.10.0.0/20"
  network       = "${var.network_self_link}"
  region        = "asia-southeast1"
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  purpose                    = "PRIVATE"
  stack_type                 = "IPV4_ONLY"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_disk" "abigail_data_disk" {
  name = "abigail-data-disk"
  type = "pd-ssd"
  size = 50
  zone = "asia-southeast1-b"
}

resource "google_compute_instance" "abigail_instance" {

  name = local.vm_name
  machine_type = "e2-medium"
  zone = "asia-southeast1-b"
  deletion_protection = false

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 25
      type  = "pd-ssd"
    }

  }
  
  attached_disk {
    source      = google_compute_disk.abigail_data_disk.id
    device_name = google_compute_disk.abigail_data_disk.name
  }

  labels = {
    ansible_host = ""
  }


  metadata = {
    block-project-ssh-keys = "true",
    ssh-keys = format("%s", var.ssh_pub_cert)
  }
  

  network_interface {
    network = "${var.network_self_link}"
    subnetwork = "${google_compute_subnetwork.asia_southeast1.name}"
    access_config {
      // Ephemeral IP
    }
  }




  service_account {
    email  = format("%s@%s.iam.gserviceaccount.com",local.vm_name, var.project_id)
    scopes = ["cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  tags = ["http-cloudflare", "https-cloudflare"]

}

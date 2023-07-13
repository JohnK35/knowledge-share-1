resource "google_compute_network" "vpc" {
  auto_create_subnetworks = false
  mtu                     = 1460
  name                    = "${format("%s","${var.company_name}-${var.env_name}-vpc")}"
  routing_mode            = "REGIONAL"
}

resource "google_compute_firewall" "allow_http_cloudflare" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "allow-http-cloudflare"
  network       = "${google_compute_network.vpc.name}"
  priority      = 1000
  source_ranges = "${var.cloudflare_ip}"
  target_tags   = ["http-cloudflare"]
}


resource "google_compute_firewall" "allow_https_cloudflare" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "allow-https-cloudflare"
  network       = "${google_compute_network.vpc.name}"
  priority      = 1000
  source_ranges = "${var.cloudflare_ip}"
  target_tags   = ["https-cloudflare"]
}

resource "google_compute_firewall" "allow_ssh_from_iap" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  description   = "ssh allow IAP-Tunnel"
  direction     = "INGRESS"
  name          = "allow-ssh-from-iap"
  network       = "${google_compute_network.vpc.name}"
  priority      = 1000
  source_ranges = ["35.235.240.0/20"]
}


resource "google_compute_firewall" "allow_all_vpc_private" {
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  description   = "Allows connection from any source to any instance on the network using custom protocols."
  direction     = "INGRESS"
  name          = "allow-all-vpc-private"
  network       = "${google_compute_network.vpc.name}"
  priority      = 65534
  source_ranges = [
    "${var.asia_southeast1_subnet}",
    "${var.us_east1_subnet}"
  ]
}


resource "google_compute_firewall" "allow_all_icmp" {
  allow {
    protocol = "icmp"
  }

  description   = "Allows ICMP connections from any source to any instance on the network."
  direction     = "INGRESS"
  name          = "allow-all-icmp"
  network       = "${google_compute_network.vpc.name}"
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow_http_cloudflare" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "allow-http-cloudflare"
  network       = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  priority      = 1000
  project       = "meawmeawx"
  source_ranges = ["103.21.244.0/22", "103.22.200.0/22", "103.31.4.0/22", "104.16.0.0/13", "104.24.0.0/14", "108.162.192.0/18", "131.0.72.0/22", "141.101.64.0/18", "162.158.0.0/15", "172.64.0.0/13", "173.245.48.0/20", "188.114.96.0/20", "190.93.240.0/20", "197.234.240.0/22", "198.41.128.0/17"]
  target_tags   = ["http-cloudflare"]
}
# terraform import google_compute_firewall.allow_http_cloudflare projects/meawmeawx/global/firewalls/allow-http-cloudflare


resource "google_compute_firewall" "allow_https_cloudflare" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "allow-https-cloudflare"
  network       = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  priority      = 1000
  project       = "meawmeawx"
  source_ranges = ["103.21.244.0/22", "103.22.200.0/22", "103.31.4.0/22", "104.16.0.0/13", "104.24.0.0/14", "108.162.192.0/18", "131.0.72.0/22", "141.101.64.0/18", "162.158.0.0/15", "172.64.0.0/13", "173.245.48.0/20", "188.114.96.0/20", "190.93.240.0/20", "197.234.240.0/22", "198.41.128.0/17"]
  target_tags   = ["https-cloudflare"]
}
# terraform import google_compute_firewall.allow_https_cloudflare projects/meawmeawx/global/firewalls/allow-https-cloudflare


resource "google_compute_firewall" "allow_ingress_from_iap" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  description   = "ssh allow IAP-Tunnel"
  direction     = "INGRESS"
  name          = "allow-ingress-from-iap"
  network       = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  priority      = 1000
  project       = "meawmeawx"
  source_ranges = ["35.235.240.0/20"]
}
# terraform import google_compute_firewall.allow_ingress_from_iap projects/meawmeawx/global/firewalls/allow-ingress-from-iap


resource "google_compute_firewall" "main_vpc_allow_custom" {
  allow {
    protocol = "all"
  }

  description   = "Allows connection from any source to any instance on the network using custom protocols."
  direction     = "INGRESS"
  name          = "main-vpc-allow-custom"
  network       = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  priority      = 65534
  project       = "meawmeawx"
  source_ranges = ["10.10.0.0/20", "10.20.0.0/20"]
}
# terraform import google_compute_firewall.main_vpc_allow_custom projects/meawmeawx/global/firewalls/main-vpc-allow-custom


resource "google_compute_firewall" "main_vpc_allow_icmp" {
  allow {
    protocol = "icmp"
  }

  description   = "Allows ICMP connections from any source to any instance on the network."
  direction     = "INGRESS"
  name          = "main-vpc-allow-icmp"
  network       = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  priority      = 65534
  project       = "meawmeawx"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.main_vpc_allow_icmp projects/meawmeawx/global/firewalls/main-vpc-allow-icmp

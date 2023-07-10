resource "google_compute_network" "main_vpc" {
  auto_create_subnetworks = false
  mtu                     = 1460
  name                    = "main-vpc"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "asia_southeast1" {
  ip_cidr_range = "10.10.0.0/20"

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  name                       = "asia-southeast1"
  network                    = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  purpose                    = "PRIVATE"
  region                     = "asia-southeast1"
  stack_type                 = "IPV4_ONLY"


resource "google_compute_subnetwork" "us_east1" {
  ip_cidr_range              = "10.20.0.0/20"
  name                       = "us-east1"
  network                    = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  purpose                    = "PRIVATE"
  region                     = "us-east1"
  stack_type                 = "IPV4_ONLY"
}


resource "google_compute_router" "nat_router_us_east1" {
  name    = "nat-router-us-east1"
  network = "https://www.googleapis.com/compute/v1/projects/meawmeawx/global/networks/main-vpc"
  region  = "us-east1"
}


resource "google_compute_address" "nat_ip_us-east1" {
  address      = "35.237.78.134"
  address_type = "EXTERNAL"
  name         = "nat_ip_us-east1"
  network_tier = "PREMIUM"
  purpose      = "NAT_AUTO"
  region       = "us-east1"
}

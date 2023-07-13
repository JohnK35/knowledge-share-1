output "subnet" {
  value       = google_compute_subnetwork.us_east1
  description = "The subnet"
}

output "haley_instance" {
  description = "An identifier for the resource with format projects/{{project}}/zones/{{zone}}/instances/{{name}}"
  value       = google_compute_instance.haley_instance
}

output "nat_address" {
  value       = google_compute_router_nat.nat_gateway_us-east1.id
  description = "NAT Gateway address"
}
output "subnet" {
  value       = google_compute_subnetwork.asia_southeast1
  description = "The subnet"
}

output "abigail_instance" {
  description = "An identifier for the resource with format projects/{{project}}/zones/{{zone}}/instances/{{name}}"
  value       = google_compute_instance.abigail_instance
}


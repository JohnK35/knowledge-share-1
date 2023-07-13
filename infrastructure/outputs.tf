output "project_id" {
  value       = var.project_id
  description = "Project ID"
}

output "abigail_instance" {
  value       = module.asia_southeast1.abigail_instance.id
  description = "abigail_instance"
}

output "haley_instance" {
  value       = module.us_east1.haley_instance.id
  description = "haley_instance"
}

output "nat_address" {
  value       = module.us_east1.nat_address
  description = "us east1 nat"
}
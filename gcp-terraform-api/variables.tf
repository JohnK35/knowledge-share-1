variable "project_id" {
  type        = string
  description = "The ID of the project to create resources in"
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "networkmanagement.googleapis.com",
  ]
}
variable "project_id" {
  type        = string
  description = "The ID of the project to create resources in"
}

variable "env_name" {
  type = string
}

variable "company_name" {
  type = string
}

variable "credentials_file_path" {
  type        = string
  description = "The credentials JSON file used to authenticate with GCP"
}

variable "service_account" {
  type        = string
  description = "The GCP service account"
}
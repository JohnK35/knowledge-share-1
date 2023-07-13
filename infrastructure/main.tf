terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

locals {
  ssh_pub = file("./ssh_remote_cert.pub")
}

provider "google" {
  project     = var.project_id
  credentials = file("../../terraform.json")
}

module "vpc" {
  source       = "./modules/global"
  env_name     = var.env_name
  company_name = var.company_name
}

module "asia_southeast1" {
  source                 = "./modules/asia-southeast1"
  env_name               = var.env_name
  company_name           = var.company_name
  network_self_link      = module.vpc.out_vpc_self_link
  project_id             = var.project_id
  asia_southeast1_subnet = module.vpc.asia_southeast1_subnet
  ssh_pub_cert           = local.ssh_pub
}

module "us_east1" {
  source            = "./modules/us-east1"
  env_name          = var.env_name
  company_name      = var.company_name
  network_self_link = module.vpc.out_vpc_self_link
  project_id        = var.project_id
  us_east1_subnet   = module.vpc.us_east1_subnet
  ssh_pub_cert      = local.ssh_pub
}

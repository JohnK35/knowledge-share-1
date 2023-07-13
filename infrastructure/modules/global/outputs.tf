output "out_vpc_self_link" { 
    value = "${google_compute_network.vpc.name}"
}

output "asia_southeast1_subnet"{
    value = "${var.asia_southeast1_subnet}"
}

output "us_east1_subnet" {
    value = "${var.us_east1_subnet}"
  
}
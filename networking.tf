resource "google_compute_global_address" "k8s-ingress" {
  name = "k8s-ingress"
}

resource "google_compute_network" "default" {
  auto_create_subnetworks = true
  description             = "Default network for the project"
  name                    = "default"
  project                 = local.project
  routing_mode            = "REGIONAL"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.default.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.default.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

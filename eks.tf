resource "google_container_cluster" "c2" {
  name     = "c2"
  location = local.main_region

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_ipv4_cidr_block = "/17"
    services_ipv4_cidr_block = "/22"
  }

  # Pod address range	10.0.0.0/14
  # Service address range	10.3.240.0/20

  # Pod address range	10.71.128.0/17
  # Service address range	10.72.0.0/22
}

resource "google_container_node_pool" "c2" {
  name       = "k8s-c2-3"
  location   = local.main_region
  cluster    = google_container_cluster.c2.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

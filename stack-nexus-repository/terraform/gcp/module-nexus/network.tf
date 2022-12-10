resource "google_compute_network" "nexus" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "nexus" {
  name          = "${var.vpc_name}-subnet"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.nexus.id
}
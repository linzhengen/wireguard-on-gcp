resource "random_id" "random-postfix" {
  byte_length = 4
}

resource "google_project" "wireguard" {
  name       = "WireGuard VPN"
  project_id = "wireguard-${random_id.random-postfix.hex}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_network" "network-vpn" {
  project                         = google_project.wireguard.id
  name                            = "network-vpn"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "subnetwork-vpn" {
  project       = google_project.wireguard.id
  ip_cidr_range = "20.11.0.0/24"
  name          = "subnetwork-vpn"
  network       = google_compute_network.network-vpn.id
  region        = local.default_region
}

resource "google_storage_bucket" "wireguard-config" {
  project  = google_project.wireguard.id
  location = "ASIA-NORTHEAST1"
  name     = "wg-config-${random_id.random-postfix.hex}"
}

module "wireguard-server" {
  source      = "../modules/wireguard"
  project     = google_project.wireguard.id
  prefix      = "vpn"
  vpc_network = google_compute_network.network-vpn.id

  config_bucket = google_storage_bucket.wireguard-config

  servers = [
    {
      name         = "wg-01"
      config_file  = ".//wg0.conf"
      subnetwork   = google_compute_subnetwork.subnetwork-vpn
      machine_type = "e2-small"
      disk_size    = "10"
      disk_type    = "pd-standard"
    },
  ]

  depends_on = [
    google_compute_subnetwork.subnetwork-vpn,
    google_storage_bucket.wireguard-config,
  ]
}

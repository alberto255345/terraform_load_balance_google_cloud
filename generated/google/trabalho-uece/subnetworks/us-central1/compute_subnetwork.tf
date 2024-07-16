resource "google_compute_subnetwork" "tfer--default" {
  ip_cidr_range              = "10.128.0.0/20"
  name                       = "default"
  network                    = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  private_ip_google_access   = "false"
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "trabalho-uece"
  purpose                    = "PRIVATE"
  region                     = "us-central1"
  stack_type                 = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "tfer--subrede" {
  ip_cidr_range              = "10.0.2.0/24"
  name                       = "subrede"
  network                    = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  private_ip_google_access   = "false"
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "trabalho-uece"
  purpose                    = "REGIONAL_MANAGED_PROXY"
  region                     = "us-central1"
  role                       = "ACTIVE"
}

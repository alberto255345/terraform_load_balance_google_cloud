resource "google_compute_firewall" "tfer--apagar" {
  allow {
    ports    = ["443", "80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "apagar"
  network       = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  priority      = "1000"
  project       = "trabalho-uece"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tfer--default-allow-icmp" {
  allow {
    protocol = "icmp"
  }

  description   = "Allow ICMP from anywhere"
  direction     = "INGRESS"
  disabled      = "false"
  name          = "default-allow-icmp"
  network       = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  priority      = "65534"
  project       = "trabalho-uece"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tfer--default-allow-internal" {
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }

  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  description   = "Allow internal traffic on the default network"
  direction     = "INGRESS"
  disabled      = "false"
  name          = "default-allow-internal"
  network       = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  priority      = "65534"
  project       = "trabalho-uece"
  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "tfer--default-allow-rdp" {
  allow {
    ports    = ["3389"]
    protocol = "tcp"
  }

  description   = "Allow RDP from anywhere"
  direction     = "INGRESS"
  disabled      = "false"
  name          = "default-allow-rdp"
  network       = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  priority      = "65534"
  project       = "trabalho-uece"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tfer--default-allow-ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  description   = "Allow SSH from anywhere"
  direction     = "INGRESS"
  disabled      = "false"
  name          = "default-allow-ssh"
  network       = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  priority      = "65534"
  project       = "trabalho-uece"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tfer--mysql" {
  allow {
    ports    = ["3306"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "mysql"
  network       = "${data.terraform_remote_state.networks.outputs.google_compute_network_tfer--default_self_link}"
  priority      = "1000"
  project       = "trabalho-uece"
  source_ranges = ["0.0.0.0/0"]
}

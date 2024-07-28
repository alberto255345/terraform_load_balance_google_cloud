provider "google" {
  credentials = file("keyfile2.json")
  project     = "test-uece-18"
  region      = "us-central1"
}

provider "google-beta" {
  credentials = file("keyfile2.json")
  project     = "test-uece-18"
  region      = "us-central1"
}

# VPC in custom mode
resource "google_compute_network" "default" {
  name                    = "l7-xlb-network"
  provider                = google-beta
  auto_create_subnetworks = false
}

# Custom subnet
resource "google_compute_subnetwork" "default" {
  name          = "l7-xlb-subnet"
  provider      = google-beta
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.default.id
}

# database
resource "google_sql_database_instance" "mysql_instance" {
  name             = "mysql-instance"
  database_version = "MYSQL_5_7"
  region          = "us-central1"

  settings {
    tier = "db-f1-micro"  # Escolha a tier conforme sua necessidade
    disk_size = 20        # Tamanho do disco em GB

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"  # Permitir acesso de qualquer IP
      }
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "my_database" {
  name     = "my_database"
  instance = google_sql_database_instance.mysql_instance.name
}

# reserved IP address
resource "google_compute_global_address" "default" {
  provider = google-beta
  name     = "l7-xlb-static-ip"
}

# forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "l7-xlb-forwarding-rule"
  provider              = google-beta
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# http proxy
resource "google_compute_target_http_proxy" "default" {
  name     = "l7-xlb-target-http-proxy"
  provider = google-beta
  url_map  = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "l7-xlb-url-map"
  provider        = google-beta
  default_service = google_compute_backend_service.default.id
}

# backend service with custom request and response headers
resource "google_compute_backend_service" "default" {
  name                    = "l7-xlb-backend-service"
  provider                = google-beta
  protocol                = "HTTP"
  port_name               = "my-port"
  load_balancing_scheme   = "EXTERNAL"
  timeout_sec             = 10
  enable_cdn              = true
  custom_request_headers  = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
  custom_response_headers = ["X-Cache-Hit: {cdn_cache_status}"]
  health_checks           = [google_compute_health_check.default.id]
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# instance template
resource "google_compute_instance_template" "default" {
  name         = "l7-xlb-mig-template"
  provider     = google-beta
  machine_type = "e2-small"
  tags         = ["allow-health-check", "ssh", "http", "mysql"]

  network_interface {
    network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id
    access_config {
      # add external ip to fetch packages
    }
  }
  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
  }

 # install nginx and serve a simple web page
  metadata = {
    startup-script = <<-EOF
      #! /bin/bash
      set -euo pipefail

      apt-get update
      apt-get install -y apache2 git

      sudo rm -rf /var/www/html/*

      git clone https://github.com/alberto255345/crud_php_simples.git /var/www/html

      chmod +x /var/www/html/inicio.sh
      cd /var/www/html
      ./inicio.sh
    EOF
  }
  lifecycle {
    create_before_destroy = true
  }
}

# health check
resource "google_compute_health_check" "default" {
  name     = "l7-xlb-hc"
  provider = google-beta
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

# MIG
resource "google_compute_instance_group_manager" "default" {
  name     = "l7-xlb-mig1"
  provider = google-beta
  zone     = "us-central1-c"
  named_port {
    name = "http"
    port = 8080
  }
  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }
  base_instance_name = "vm"
  target_size        = 1
}

# allow access from health check ranges
resource "google_compute_firewall" "default" {
  name          = "l7-xlb-fw-allow-hc"
  provider      = google-beta
  direction     = "INGRESS"
  network       = google_compute_network.default.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "icmp"
  }
  target_tags = ["allow-health-check"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.default.id
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = google_compute_network.default.id
  
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http"]
}

resource "google_compute_firewall" "allow-mysql" {
  name    = "allow-mysql"
  network = google_compute_network.default.id
  
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["mysql"]
}
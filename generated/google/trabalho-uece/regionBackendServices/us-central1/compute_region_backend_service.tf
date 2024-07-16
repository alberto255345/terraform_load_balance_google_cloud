resource "google_compute_region_backend_service" "tfer--backend-loadbalance" {
  affinity_cookie_ttl_sec = "0"

  backend {
    balancing_mode               = "RATE"
    capacity_scaler              = "1"
    failover                     = "false"
    group                        = "https://www.googleapis.com/compute/v1/projects/trabalho-uece/zones/us-central1-f/networkEndpointGroups/backend"
    max_connections              = "0"
    max_connections_per_endpoint = "0"
    max_connections_per_instance = "0"
    max_rate                     = "0"
    max_rate_per_endpoint        = "59"
    max_rate_per_instance        = "0"
    max_utilization              = "0"
  }

  connection_draining_timeout_sec = "300"
  enable_cdn                      = "false"
  health_checks                   = ["https://www.googleapis.com/compute/v1/projects/trabalho-uece/regions/us-central1/healthChecks/testhealth"]
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  locality_lb_policy              = "ROUND_ROBIN"
  name                            = "backend-loadbalance"
  port_name                       = "http"
  project                         = "trabalho-uece"
  protocol                        = "HTTP"
  region                          = "us-central1"
  session_affinity                = "NONE"
  timeout_sec                     = "30"
}

resource "google_compute_instance_group_manager" "tfer--instance-group-1-uece" {
  base_instance_name = "instance-group-1-uece"
  name               = "instance-group-1-uece"

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

  named_port {
    name = "mysql"
    port = "3306"
  }

  project     = "trabalho-uece"
  target_size = "1"

  update_policy {
    max_surge_fixed         = "1"
    max_surge_percent       = "0"
    max_unavailable_fixed   = "1"
    max_unavailable_percent = "0"
    min_ready_sec           = "0"
    minimal_action          = "REPLACE"
    replacement_method      = "SUBSTITUTE"
    type                    = "OPPORTUNISTIC"
  }

  version {
    instance_template = "https://www.googleapis.com/compute/v1/projects/trabalho-uece/regions/us-central1/instanceTemplates/template-uece-maquina"
  }

  wait_for_instances_status = "STABLE"
  zone                      = "us-central1-f"
}

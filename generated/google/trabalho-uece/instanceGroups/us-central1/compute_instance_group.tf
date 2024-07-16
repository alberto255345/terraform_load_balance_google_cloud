resource "google_compute_instance_group" "tfer--us-central1-f-002F-instance-group-1-uece" {
  description = "This instance group is controlled by Instance Group Manager 'instance-group-1-uece'. To modify instances in this group, use the Instance Group Manager API: https://cloud.google.com/compute/docs/reference/latest/instanceGroupManagers"
  instances   = ["https://www.googleapis.com/compute/v1/projects/trabalho-uece/zones/us-central1-f/instances/instance-group-1-uece-gj5c"]
  name        = "instance-group-1-uece"

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

  network = "https://www.googleapis.com/compute/v1/projects/trabalho-uece/global/networks/default"
  project = "trabalho-uece"
  zone    = "us-central1-f"
}

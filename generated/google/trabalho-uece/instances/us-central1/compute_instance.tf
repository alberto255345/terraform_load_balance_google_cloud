resource "google_compute_instance" "tfer--instance-group-1-uece-gj5c" {
  boot_disk {
    auto_delete = "true"
    device_name = "template-uece-maquina"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/trabalho-uece/zones/us-central1-f/disks/instance-group-1-uece-gj5c"
  }

  can_ip_forward = "false"

  confidential_instance_config {
    enable_confidential_compute = "false"
  }

  deletion_protection = "false"
  enable_display      = "false"
  machine_type        = "t2a-standard-1"

  metadata = {
    created-by        = "projects/786239718775/zones/us-central1-f/instanceGroupManagers/instance-group-1-uece"
    instance-template = "projects/786239718775/regions/us-central1/instanceTemplates/template-uece-maquina"
    ssh-keys          = "alberto_neto94:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHg09m5SH/3floAZZFjlL+eeiy71o/KJE7a9zIkkpQuhfz9Z37EXBjIpVTciXbDrJB1VmBO/bzlcHfFN/FVOMOI= google-ssh {\"userName\":\"alberto.neto94@gmail.com\",\"expireOn\":\"2024-06-28T00:31:27+0000\"}\nalberto_neto94:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCUhzf4tAm39CEnl5germiWMTB//vQ1pE+CZd8xlrKa+OpkrNu+q5N3Rhtm7fhkywrMjt7zBZgkYcOT/4sMIUhJno+jNeVqQlYHgpzIpMpdgvn5aufNdFIWsQ7UGZtde7BU+Hxgsz0jBulEaKwc2QTuC59erLdWKROPKadRGAJKMFyimGpammxYClIXW6CJcQ7p86TbsCcSMBTIYLpCiX+rltSfccII+tNETiAAGRxw2MCA26NChHg2pq+OVNPvK9lA9BZjlKiwUq+fLN6dP75yYZWHEdpLOqVJifd/EtECsJouPFNB+w9avIppBV9ljhd7KumaGwMinmtq4WqSKImn google-ssh {\"userName\":\"alberto.neto94@gmail.com\",\"expireOn\":\"2024-06-28T00:31:47+0000\"}"
  }

  name = "instance-group-1-uece-gj5c"

  network_interface {
    access_config {
      nat_ip       = "34.135.31.177"
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/trabalho-uece/global/networks/default"
    network_ip         = "10.128.0.4"
    nic_type           = "GVNIC"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/trabalho-uece/regions/us-central1/subnetworks/default"
    subnetwork_project = "trabalho-uece"
  }

  project = "trabalho-uece"

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "786239718775-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  tags = ["http-server", "https-server", "lb-health-check"]
  zone = "us-central1-f"
}

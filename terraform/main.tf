# init
#terraform {
  #required_version = "0.12.24"
#}

provider "google" {
  #version = "2.15"
  project = var.project
  region  = var.region
}

# add ssh-keys into project
resource "google_compute_project_metadata_item" "appuser_key" {
  key   = "ssh-keys"
  value = var.ssh-keys
}

# add firewall rule
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

# 9292 healthcheck
resource "google_compute_http_health_check" "tcp-9292-check" {
  name               = "tcp-9292-check"
  request_path       = "/"
  port               = 9292
  check_interval_sec = 10
  timeout_sec        = 3
}

# lets create instances
resource "google_compute_instance" "app" {
  count        = var.howmany
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  network_interface {
    network = "default"
    access_config {}
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

# and put them into the pool
resource "google_compute_target_pool" "nlb-target-pool" {
  name             = "nlb-target-pool"
  session_affinity = "NONE"
  region           = var.region

  instances = google_compute_instance.app.*.self_link

  health_checks = [
    google_compute_http_health_check.tcp-9292-check.name
  ]
}

# create forwarding rule
resource "google_compute_forwarding_rule" "network-load-balancer" {
  name                  = "nlb-test"
  region                = var.region
  target                = google_compute_target_pool.nlb-target-pool.self_link
  port_range            = "9292"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
}
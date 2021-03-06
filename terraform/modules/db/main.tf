resource "google_compute_instance" "db" {
  name = "${lower(var.env_sfx)}-reddit-db"
  #name         = "reddit-db"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-db"]
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.db_ip.address
    }
  }

  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "db_ip" {
  name = "reddit-${lower(var.env_sfx)}-db-ip"
}


resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-${lower(var.env_sfx)}-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}

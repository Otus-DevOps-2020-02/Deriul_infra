variable public_key_path {
  description = "Path to the public key used to connect to instance"
  default     = "~/.ssh/appuser.pub"
}

variable private_key_path {
  description = "Path to the public key used to connect to instance"
  default     = "~/.ssh/appuser"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-1587343003"
}

variable env_sfx {}

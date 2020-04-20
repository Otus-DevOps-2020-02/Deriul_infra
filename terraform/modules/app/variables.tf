
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

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-1587342813"
}

variable db_internal_ip {}
variable env_sfx {}

variable dep_sw {
  type = bool
}

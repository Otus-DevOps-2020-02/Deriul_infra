variable project {
  description = "Project ID"
  default     = "infra-271122"
}
variable region {
  description = "Region"
  default     = "europe-west1"
}

variable source_ranges {}

variable env {}

variable dep_sw {
  type = bool
}
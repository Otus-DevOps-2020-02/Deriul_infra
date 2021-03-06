# 9292 healthcheck
resource "google_compute_http_health_check" "tcp-9292-check" {
  name               = "tcp-9292-check"
  request_path       = "/"
  port               = 9292
  check_interval_sec = 10
  timeout_sec        = 3
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
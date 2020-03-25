output "network_load_balancer_ip" {
  value = "${google_compute_forwarding_rule.network-load-balancer.ip_address}"
}

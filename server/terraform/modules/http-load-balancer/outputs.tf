# Load Balancer Outputs

output "load_balancer_ipv4_address" {
  description = "IP address of the Cloud Load Balancer"
  value       = google_compute_global_address.ipv4.address
}

resource "google_monitoring_uptime_check_config" "https" {
  display_name = "https://${var.service_name}.${var.google_domain_name}"
  timeout      = "60s"
  project      = var.project_id

  http_check {
    path         = "/"
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "${var.service_name}.${var.google_domain_name}"
    }
  }
}

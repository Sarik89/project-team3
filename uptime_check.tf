module "uptime_check" {
  source             = "./module/monitoring"
  google_domain_name = var.google_domain_name
  project_id        = var.project_id
  service_name       = "application"
}

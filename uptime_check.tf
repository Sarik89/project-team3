module "uptime_check" {
  source             = "./module/monitoring"
  google_domain_name = var.google_domain_name
  PROJECT_ID         = var.project_id
  service_name       = "uptime_check"
}

output "resource_name" {
  value = google_secret_manager_secret.trend_micro_fss_secret.name
}

output "resource_secret_id" {
  value = google_secret_manager_secret.trend_micro_fss_secret.secret_id
}

output "resource_secret" {
  value = google_secret_manager_secret.trend_micro_fss_secret
}
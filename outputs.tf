output "instance_name" {
  description = "The name of the database instance"
  value       = google_sql_database_instance.instance.name
}

output "instance_address" {
  description = "The first IPv4 address of any type assigned to the master database instance"
  value       = google_sql_database_instance.instance.ip_address.0.ip_address
}

output "instance_address_time_to_retire" {
  description = "The time the master instance IP address will be retired. RFC 3339 format."
  value       = google_sql_database_instance.instance.ip_address.0.time_to_retire
}

output "self_link" {
  description = "Self link to the master instance"
  value       = google_sql_database_instance.instance.self_link
}

output "connection_name" {
  description = "The connection name of the instance to be used in connection strings"
  value       = google_sql_database_instance.instance.connection_name
}

output "instance_public_ip" {
  description = "The public ip address to access the instance at"
  value       = google_sql_database_instance.instance.public_ip_address
}

output "instance_private_ip" {
  description = "The private ip address to access the instance at"
  value       = google_sql_database_instance.instance.private_ip_address
}

output "instance_sa" {
  description = "The service account email address assigned to the instance."
  value       = google_sql_database_instance.instance.service_account_email_address
}

output "instance_client_priv_key" {
  value = google_sql_ssl_cert.client_cert.private_key
}
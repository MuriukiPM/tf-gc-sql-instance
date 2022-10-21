terraform {
  required_version = ">= 1.1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.39.0"
    }
  }
}

resource "google_sql_database_instance" "instance" {
  name                = var.instance_name
  project             = var.instance_project
  region              = var.instance_region
  database_version    = var.instance_database_version
  deletion_protection = var.instance_deletion_protection

  depends_on = [var.instance_private_connect]

  settings {
    tier              = var.instance_tier
    availability_type = var.instance_availability_type
    activation_policy = var.instance_activation_policy
    disk_autoresize   = var.instance_disk_autoresize
    disk_size         = var.instance_disk_size
    disk_type         = var.instance_disk_type

    dynamic "location_preference" {
      for_each = [var.instance_location_preference]
      content {
        follow_gae_application = lookup(location_preference.value, "follow_gae_application", null)
        zone                   = lookup(location_preference.value, "zone", null)
      }
    }

    dynamic "ip_configuration" {
      for_each = [var.instance_ip_configuration]
      content {

        ipv4_enabled    = lookup(ip_configuration.value, "ipv4_enabled", true)
        private_network = lookup(ip_configuration.value, "private_network", null)
        require_ssl     = lookup(ip_configuration.value, "require_ssl", true)

        dynamic "authorized_networks" {
          for_each = lookup(ip_configuration.value, "authorized_networks", [])
          content {
            expiration_time = lookup(authorized_networks.value, "expiration_time", null)
            name            = lookup(authorized_networks.value, "name", null)
            value           = lookup(authorized_networks.value, "value", null)
          }
        }
      }
    }

    dynamic "backup_configuration" {
      for_each = [var.instance_backup_configuration]
      content {

        binary_log_enabled             = lookup(backup_configuration.value, "binary_log_enabled", false)
        enabled                        = lookup(backup_configuration.value, "enabled", false)
        start_time                     = lookup(backup_configuration.value, "start_time", "04:00")
        point_in_time_recovery_enabled = lookup(backup_configuration.value, "point_in_time_recovery_enabled", false)
      }
    }

    dynamic "maintenance_window" {
      for_each = [var.instance_maintenance_window]
      content {

        day          = lookup(maintenance_window.value, "day", 7)  #sunday
        hour         = lookup(maintenance_window.value, "hour", 0) #utc
        update_track = lookup(maintenance_window.value, "update_track", "stable")
      }
    }
  }
}

resource "google_sql_ssl_cert" "client_cert" {
  common_name = var.instance_client_cert_name
  instance    = google_sql_database_instance.instance.name
}

resource "google_sql_database" "database" {
  for_each = var.instance_databases
  name     = each.value.name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "user" {
  for_each = var.instance_users
  name     = each.value.name
  instance = google_sql_database_instance.instance.name
  password = each.value.password
  lifecycle {
    ignore_changes = [
      password
    ]
  }
}

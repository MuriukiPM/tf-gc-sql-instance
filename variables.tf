variable "instance_name" {
  description = "Name of the instance or replica instance in replication setup. If left blank (replica), terraform will autogenerate one"
}

variable "instance_project" {
  description = "The project to deploy to, if not set the default provider project is used."
}

variable "instance_region" {
  description = "Region for cloud resources"
}

variable "instance_database_version" {
  description = "The version of of the database. For example, `MYSQL_5_6` or `POSTGRES_9_6`."
}

variable "instance_deletion_protection" {
  type        = bool
  description = "whether to protect the instance from deletion or not"
  default     = true
}

variable "instance_private_connect" {
  description = "The google_service_networking_connection for private IP instance setup"
}

variable "instance_tier" {
  description = "The machine type (Second Generation)."
}

variable "instance_availability_type" {
  description = "This specifies whether a CloudSQL instance should be set up for high availability (REGIONAL) or single zone (ZONAL)."
}

variable "instance_activation_policy" {
  description = "This specifies when the instance should be active. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  default     = "ALWAYS"
}

variable "instance_disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically."
}

variable "instance_disk_size" {
  description = "Second generation only. The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
}

variable "instance_disk_type" {
  description = "Second generation only. The type of data disk: `PD_SSD` or `PD_HDD`."
}

variable "instance_location_preference" {
  description = "The location_preference settings subblock"
  default     = {}
}

variable "instance_ip_configuration" {
  description = "The ip_configuration settings subblock"
  default     = {}
}

variable "instance_backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  default     = {}
}

variable "instance_maintenance_window" {
  description = "The maintenance_window settings subblock"
  default     = {}
}

variable "instance_client_cert_name" {
  description = "Name of the common name for the client ssl cert"
}

variable "instance_databases" {
  description = "Map of databases to create in the instance"
  default     = {}
}

variable "instance_users" {
  description = "Map of databases to create in the instance"
  default     = {}
}

variable "db_charset" {
  description = "The charset for the default database. Example 'UTF8' for Postgres"
  default     = ""
}

variable "db_collation" {
  description = "The collation for the default database. Example for MySQL databases: 'utf8_general_ci', and Postgres: 'en_US.UTF8'"
  default     = ""
}

variable "user_host" {
  description = "The host the user can connect from. This is only supported for MySQL instances. Don't set this field for PostgreSQL instances. Can be an IP address. Changing this forces a new resource to be created."
  default     = "%"
}

variable "master_instance_name" {
  description = "The name of the master instance to replicate"
  default     = ""
}

variable "replica_configuration" {
  description = "The optional replica_configuration block for the database instance"
  default     = {}
}

variable "postgres_resources_prefix" {
  description = ""
  type = string
  default = "psql-"
}

variable "environment" {
  description = "Deployment environment of the PostgreSQL cluster (PRODUCTION or PRESTABLE)"
  type = string
  default = "PRODUCTION"
}

variable "name" {
  description = "Name of the PostgreSQL cluster. Provided by the client when the cluster is created."
  type = string
}

variable "description" {
  description = "Description of the PostgreSQL cluster."
  type = string
  default = null
}

variable "network_id" {
  description = "ID of the network, to which the PostgreSQL cluster belongs."
  type        = string
}

variable "postgres_version" {
  description = "Version of the PostgreSQL cluster."
  type        = number
}

variable "folder_id" {
  description = "The ID of the folder that the PostrgreSQL cluster belongs to."
  type        = string
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the PostgreSQL cluster."
  type = map(string)
  default = {}
}

variable "host_master_name" {
  description = "It sets name of master host. It works only when host.name is set."
  type        = string
}

variable "default_security_groups" {
  description = "Create default security groups"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster."
  type        = set(string)
  default     = null
}

variable "deletion_protection" {
  description = "Inhibits deletion of the cluster. Can be either true or false."
  type        = string
  default     = true
}



variable "disk_size" {
  description = "Volume of the storage available to a PostgreSQL host, in gigabytes."
  type = number
  default = 10
}

variable "disk_type_id" {
  description = "Type of the storage of PostgreSQL hosts."
  type = string
  default = "network-ssd"
}

variable "resources_preset_id" {
  description = "The ID of the preset for computational resources available to a PostgreSQL host (CPU, memory etc.)."
  type = string
  default = "s2.micro"
}


variable "autofailover" {
  description = "Configuration setting which enables/disables autofailover in cluster."
  type = bool
  default = true
}


# Backup policies
variable "backup_retain_period_days" {
  description = "The period in days during which backups are stored."
  type = number
  default = 7
}

variable "backup_hour" {
  description = "The hour at which backup will be started (UTC)."
  type = number
  default = 1
}

variable "backup_minutes" {
  description = "The minute at which backup will be started (UTC)."
  type = number
  default = 0
}


# Access policy to the PostgreSQL cluster.
variable "access_data_lens" {
  description = "Allow access for Yandex DataLens."
  type = bool
  default = false
}

variable "access_web_sql" {
  description = "Allow access for SQL queries in the management console"
  type = bool
  default = false
}

variable "access_serverless" {
  description = "Allow access for connection to managed databases from functions"
  type = bool
  default = false
}



# Cluster performance diagnostics settings.
variable "performance_diagnostics_enabled" {
  description = "Enable performance diagnostics"
  type = bool
  default = false
}

variable "performance_diagnostics_sessions_sampling_interval" {
  description = "Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive."
  type = number
  default = null
}

variable "performance_diagnostics_statements_sampling_interval" {
  description = "Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive."
  type = number
  default = null
}


# Maintenance policy of the PostgreSQL cluster.
variable "maintenance_window_type" {
  description = "Type of maintenance window. Can be either ANYTIME or WEEKLY."
  type = string
  default = "WEEKLY"
}

variable "maintenance_window_day" {
  description = "Day of the week (in DDD format). Allowed values: MON, TUE, WED, THU, FRI, SAT, SUN."
  type = string
  default = "SUN"
}

variable "maintenance_window_hour" {
  description = "Hour of the day in UTC (in HH format). Allowed value is between 1 and 24."
  type = number
  default = 3
}


# A host of the PostgreSQL cluster.
variable "zone" {
  description = "The availability zone where the PostgreSQL host will be created."
  type = string
}

variable "assign_public_ip" {
  description = "Sets whether the host should get a public IP address on creation. It can be changed on the fly only when name is set."
  type = bool
  default = false
}

variable "subnet_id" {
  description = "The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs."
  type = string
}

variable "host_name" {
  description = "Host replication source name points to host's name from which this host should replicate. When not set then host in HA group. It works only when name is set."
  type = string
}

variable "replication_source_name" {
  description = "Host replication source name points to host's name from which this host should replicate. When not set then host in HA group. It works only when name is set."
  type = string
  default = null
}






variable "postgres_databases" {
  description = "Databases to create in Managed Service for PostgreSQL"
  type = map(object({
    user     = string
    password = string
    grants = string
    settings = map(object({
      conn_limit = number
      lc_collate = string
      lc_type = string
      default_transaction_isolation = string
      temp_file_limit = number
      log_statement = string
    }))
  }))
}

variable "whitelist_ips" {
  description = "List of IPs to access PostgreSQL cluster"
  type        = list(string)
  default     = []
}


variable "service_account_id" {
  description = <<-EOF
  ID of existing service account to be used for provisioning Compute Cloud
  and VPC resources for PostgreSQL cluster.
  EOF
  type        = string
  default     = null
}

variable "service_account_name" {
  description = <<-EOF
  Name of service account to create to be used for provisioning Compute Cloud
  and VPC resources for PostgreSQL cluster.
  `service_account_name` is ignored if `service_account_id` is set.
  EOF
  type        = string
  default     = null
}
locals {
  security_group_ids = var.default_security_groups == true ? setunion([
    yandex_vpc_security_group.postgres[0].id
  ], var.security_group_ids) : var.security_group_ids
}

resource "yandex_mdb_postgresql_cluster" "postgres" {
  name                = var.name
  description         = var.description
  environment         = var.environment
  network_id          = var.network_id
  folder_id           = var.folder_id
  labels              = var.labels
  host_master_name    = var.host_master_name
  security_group_ids  = var.security_group_ids
  deletion_protection = var.deletion_protection

  config {
    version = var.postgres_version

    resources {
      resource_preset_id = var.resources_preset_id
      disk_type_id       = var.disk_type_id
      disk_size          = var.disk_size
    }

    # Access policy to the PostgreSQL cluster.
    access {
      data_lens  = var.access_data_lens
      web_sql    = var.access_web_sql
      serverless = var.access_serverless
    }

    #
    performance_diagnostics {
      enabled                      = var.performance_diagnostics_enabled
      sessions_sampling_interval   = var.performance_diagnostics_sessions_sampling_interval
      statements_sampling_interval = var.performance_diagnostics_statements_sampling_interval
    }

    autofailover              = var.autofailover
    backup_retain_period_days = var.backup_retain_period_days
    backup_window_start {
      hours   = var.backup_hour
      minutes = var.backup_minutes
    }

    #    pooler_config {
    #      # (Optional) Setting pool_discard parameter in Odyssey.
    #      pool_discard = ""
    #      # (Optional) Mode that the connection pooler is working in.
    #      pooling_mode = ""
    #    }

    postgresql_config {
      max_connections                   = 200
      enable_parallel_hash              = true
      vacuum_cleanup_index_scale_factor = 0.2
      autovacuum_vacuum_scale_factor    = 0.34
      default_transaction_isolation     = "TRANSACTION_ISOLATION_READ_COMMITTED"
      shared_preload_libraries          = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
    }
  }

  # Maintenance policy of the PostgreSQL cluster.
  maintenance_window {
    type = var.maintenance_window_type
    day  = var.maintenance_window_day
    hour = var.maintenance_window_hour
  }

  dynamic "database" {
    for_each = var.postgres_databases
    content {
      name       = database.key
      owner      = database.key
      lc_collate = defaults(database.value.settings.lc_collate, "C")
      lc_type    = defaults(database.value.settings.lc_type, "C")
    }
  }

  dynamic "user" {
    for_each = var.postgres_databases
    content {
      name       = user.key
      password   = user.value.password
      conn_limit = defaults(user.value.settings.conn_limit, 30)
      grants     = defaults(user.value.grants, user.key)
      permission {
        database_name = user.key
      }
      settings = {
        default_transaction_isolation = defaults(user.value.settings.default_transaction_isolation, "read committed")
        lock_timeout                  = 0
        log_min_duration_statement    = 5000
        synchronous_commit            = 0
        temp_file_limit               = defaults(user.value.settings.temp_file_limit, null)
        log_statement                 = defaults(user.value.settings.log_statement, null)
      }
    }
  }

  host {
    zone                    = var.zone
    subnet_id               = var.subnet_id
    assign_public_ip        = var.assign_public_ip
    name                    = var.host_name
    replication_source_name = var.replication_source_name
  }
}


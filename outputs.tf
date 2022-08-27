output "cluster_id" {
  description = "ID of a new PostgreSQL cluster."
  value       = yandex_mdb_postgresql_cluster.postgres.id
}

output "service_account_id" {
  description = <<-EOF
  ID of service account used for provisioning PostgreSQL cluster
  EOF
  value       = local.service_account_id
}

output "hosts" {
  description = "PostgreSQL hosts"
  value       = yandex_mdb_postgresql_cluster.postgres.host.fqdn
}

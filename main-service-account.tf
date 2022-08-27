locals {
  service_account_name = var.service_account_id == null ? var.service_account_name : null
  service_account_id = try(
    yandex_iam_service_account.postgres[0].id,
    var.service_account_id
  )
}

resource "yandex_iam_service_account" "postgres" {
  count = local.service_account_name == null ? 0 : 1

  folder_id   = var.folder_id
  name        = var.service_account_name
  description = "Service account for PostgreSQL cluster"
}

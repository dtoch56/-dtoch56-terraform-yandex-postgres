# Yandex.Cloud Managet PostgreSQL module

Creates a Yandex Managed Service for PostgreSQL in Yandex.Cloud.

## Basic example

To create an PostgreSQL cluster named `my-psql` in Yandex.Cloud folder with id `xxx000xxx000xxx000xx`:

```hcl
module "postgres" {
  source  = "dtoch56/postgres/yandex"

  cloud_id    = "xxx000xxx000xxx000xx"
  folder_name = "my-psql"
}
```

## Requirements

| Name                                            | Version |
|-------------------------------------------------|---------|
| [terraform](https://www.terraform.io/downloads) | >= 1.2  |

## Providers

| Name                                                                                    | Version |
|-----------------------------------------------------------------------------------------|---------|
| [yandex-cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) | >= 0.77 |

## Modules

No modules.

## Resources

| Name                                                                                                                                 | Type     |
|--------------------------------------------------------------------------------------------------------------------------------------|----------|
| [mdb_postgresql_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_postgresql_cluster)   | resource |
| [mdb_postgresql_user](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_postgresql_user)         | resource |
| [mdb_postgresql_database](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_postgresql_database) | resource |
| [yandex_iam_service_account](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account)  | resource |

## Inputs

| Name                          | Description                                                                                                                                               | Type     | Required | Default |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|:--------:|---------|

## Outputs

| Name                    | Description                                                                                        |
|-------------------------|----------------------------------------------------------------------------------------------------|
| cluster_id              | ID of a new PostgreSQL cluster.                                                                    | 
| service_account_id      | ID of service account used for provisioning Compute Cloud and VPC resources for PostgreSQL cluster | 




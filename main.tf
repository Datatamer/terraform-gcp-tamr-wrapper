locals {
  subnetwork = replace(var.subnet_self_link, "https://www.googleapis.com/compute/v1/", "")

  # some resources have a force destroy (gcs), but others are deletion protection
  # (bigtable), need to have the opposite bool value.
  deletion_protection = var.force_destroy == true ? false : true

  admin_users = concat(
    var.additional_admin_users,
    [
      "serviceAccount:${module.iam.service_account_email}",
    ]
  )
  read_users = concat(
    var.additional_read_users,
    [
      "serviceAccount:${module.iam.service_account_email}",
    ]
  )
}

#tfsec:ignore:google-iam-no-project-level-service-account-impersonation
module "iam" {
  source = "git::https://github.com/Datatamer/terraform-gcp-tamr-iam?ref=v2.0.1"

  project_id           = var.project_id
  tamr_service_account = var.tamr_instance_service_account
}

#tfsec:ignore:google-sql-enable-pg-temp-file-logging tfsec:ignore:google-sql-encrypt-in-transit-data tfsec:ignore:google-sql-no-public-access tfsec:ignore:google-sql-pg-log-checkpoints tfsec:ignore:google-sql-pg-log-connections tfsec:ignore:google-sql-pg-log-disconnections tfsec:ignore:google-sql-pg-log-lock-waits
module "cloud_sql" {
  source = "git::https://github.com/Datatamer/terraform-gcp-tamr-cloud-sql.git?ref=v5.5.0"
  name   = var.deployment_name

  deletion_protection = local.deletion_protection

  project_id = var.project_id
  labels     = var.labels
  region     = var.region

  disk_size = var.sql_disk_size
  disk_type = var.sql_disk_type
  tier      = var.sql_tier

  enable_private_ip  = var.enable_cloud_sql_private_ip
  private_network_id = var.private_network_id

  require_ssl = var.require_ssl
  ssl_mode    = var.ssl_mode
}

#tfsec:ignore:google-storage-bucket-encryption-customer-key tfsec:ignore:google-storage-enable-ubla
module "gcs_buckets" {
  source = "git::https://github.com/Datatamer/terraform-gcp-tamr-buckets.git?ref=v3.0.0"

  project_id    = var.project_id
  labels        = var.labels
  force_destroy = var.force_destroy

  bucket_write_members = local.admin_users
  bucket_read_members  = local.read_users

  bucket_name_prefix = var.deployment_name
  bucket_locations   = var.bucket_locations
}

module "bigtable" {
  source = "git::https://github.com/Datatamer/terraform-gcp-bigtable.git?ref=v3.0.0"

  name    = var.deployment_name
  project = var.project_id
  zone    = var.zone

  deletion_protection = local.deletion_protection

  cloud_bigtable_admin_members = local.admin_users
}

#tfsec:ignore:google-compute-enable-shielded-vm-im tfsec:ignore:google-compute-enable-shielded-vm-vtpm tfsec:ignore:google-compute-no-project-wide-ssh-keys tfsec:ignore:google-compute-vm-disk-encryption-customer-key
module "tamr_vm" {
  source = "git::https://github.com/Datatamer/terraform-gcp-tamr-vm.git?ref=v2.2.1"
  # tamr VM
  tamr_instance_name                = var.deployment_name
  tamr_instance_zone                = var.zone
  tamr_instance_image               = var.tamr_instance_image
  tamr_instance_service_account     = module.iam.service_account_email
  tamr_instance_subnet              = local.subnetwork
  tamr_instance_project             = var.project_id
  tamr_instance_tags                = var.tamr_instance_tags
  tamr_zip_uri                      = var.tamr_zip_uri
  tamr_instance_deletion_protection = local.deletion_protection
  # filesystem
  tamr_filesystem_bucket = module.gcs_buckets.tamr_bucket_name
  # config
  tamr_config_file = module.config.tamr_config_file
  # misc
  labels           = var.labels
  metadata         = var.tamr_instance_metadata
  pre_install_bash = var.pre_install_bash
  # boot disk
  tamr_instance_disk_size = var.tamr_instance_disk_size
  tamr_instance_disk_type = var.tamr_instance_disk_type
}

module "config" {
  source = "git::https://github.com/Datatamer/terraform-gcp-tamr-config.git?ref=v3.0.1"

  # tamr VM
  tamr_instance_zone            = var.zone
  tamr_instance_subnet          = local.subnetwork
  tamr_instance_service_account = module.iam.service_account_email
  tamr_instance_project         = var.project_id
  tamr_instance_internal_ip     = module.tamr_vm.tamr_instance_internal_ip
  # bigtable config
  tamr_bigtable_instance_id = module.bigtable.bigtable_instance_id
  tamr_bigtable_cluster_id  = module.bigtable.bigtable_cluster_id
  tamr_bigtable_min_nodes   = var.tamr_bigtable_min_nodes
  tamr_bigtable_max_nodes   = var.tamr_bigtable_max_nodes
  # dataproc
  tamr_dataproc_bucket  = module.gcs_buckets.dataproc_bucket_name
  tamr_dataproc_region  = var.region
  dataproc_network_tags = var.dataproc_network_tags
  # dataproc_cluster_config
  tamr_dataproc_cluster_subnetwork_uri        = local.subnetwork
  tamr_dataproc_cluster_zone                  = var.zone
  tamr_dataproc_cluster_master_instance_type  = var.dataproc_cluster_master_instance_type
  tamr_dataproc_cluster_master_disk_size      = var.dataproc_cluster_master_disk_size
  tamr_dataproc_cluster_worker_machine_type   = var.dataproc_cluster_worker_machine_type
  tamr_dataproc_cluster_worker_num_instances  = var.dataproc_cluster_worker_num_instances
  tamr_dataproc_cluster_worker_num_local_ssds = var.dataproc_cluster_worker_num_local_ssds
  tamr_dataproc_image_version                 = var.dataproc_image_version
  # spark
  tamr_spark_driver_memory       = var.spark_driver_memory
  tamr_spark_executor_memory     = var.spark_executor_memory
  tamr_spark_executor_cores      = var.spark_executor_cores
  tamr_spark_executor_instances  = var.spark_executor_instances
  tamr_spark_properties_override = var.spark_properties_override
  # cloud sql
  tamr_cloud_sql_location = var.region
  tamr_cloud_sql_name     = module.cloud_sql.instance_name
  tamr_sql_password       = module.cloud_sql.tamr_password
  tamr_cloud_sql_sslmode  = var.tamr_cloud_sql_sslmode
  # filesystem
  tamr_filesystem_bucket = module.gcs_buckets.tamr_bucket_name
  # Miscellaneous
  tamr_license_key = var.tamr_license_key
}

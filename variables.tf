#
# IAM
#
variable "additional_admin_users" {
  default     = []
  type        = list(string)
  description = "list of additional entities to give admin permissions to provisioned resources"
}

variable "additional_read_users" {
  default     = []
  type        = list(string)
  description = "list of additional entities to give read only permissions to provisioned resources"
}

variable "tamr_instance_service_account" {
  type        = string
  description = "email of service account to attach to the tamr instance. If not given will create a new service account for tamr to use."
}

#
# Tamr VM
#
variable "tamr_instance_image" {
  type        = string
  description = "Image to use for Tamr VM boot disk"
}

variable "tamr_zip_uri" {
  type        = string
  description = "gcs location to download tamr zip from"
}

variable "tamr_instance_tags" {
  default     = []
  type        = list(string)
  description = "list of network tags to attach to instance"
}

variable "tamr_instance_metadata" {
  default     = {}
  type        = map(string)
  description = "custom metadata to attach to created VM"
}

variable "pre_install_bash" {
  default     = ""
  type        = string
  description = <<EOF
  Bash to be run before Tamr is installed.
  Likely to be used to meet Tamr's prerequisites, if not already met by the image. (https://docs.tamr.com/new/docs/requirements )
   This will only be run once before Tamr is installed, unless Tamr fails to install. This bash will also be run on subsequent attempts to install Tamr, so it is recommended that this bash is idempotent.
  EOF
}

# TODO: vm settings


#
# GCP LB
#
# TODO:

#
# SQL
#
variable "sql_tier" {
  type        = string
  description = "the machine type to use for the sql instance"
  default     = "db-custom-2-4096"
}

variable "sql_disk_size" {
  type        = number
  description = "size of the disk to use on the tamr sql instance"
  default     = 10
}

variable "sql_disk_type" {
  type        = string
  description = "The disk type to use on the cloud SQL instance. should be either PD_SSD or PD_STANDARD"
  default     = "PD_SSD"
}

variable "enable_cloud_sql_private_ip" {
  type        = bool
  description = "Whether the Cloud SQL instance should use a public or private ip address"
  default     = false
}

variable "private_network_id" {
  type        = string
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP"
  default     = ""
}

#
# Bigtable
#
variable "tamr_bigtable_min_nodes" {
  type        = number
  description = "Min number of nodes to scale down to"
  default     = 1
}

variable "tamr_bigtable_max_nodes" {
  type        = number
  description = "Max number of nodes to scale up to"
}

#
# Dataproc
#
variable "dataproc_network_tags" {
  default     = []
  type        = list(string)
  description = "list of network tags to attach to each dataproc node"
}
variable "dataproc_cluster_master_instance_type" {
  default     = "n1-highmem-4"
  type        = string
  description = "Instance type to use as dataproc master"
}

variable "dataproc_cluster_master_disk_size" {
  default     = 1000
  type        = number
  description = "Size of disk to use on dataproc master disk"
}

variable "dataproc_cluster_worker_machine_type" {
  default     = "n1-standard-16"
  type        = string
  description = "machine type of default worker pool"
}

variable "dataproc_cluster_worker_num_instances" {
  default     = 4
  type        = number
  description = "Number of default workers to use"
}

variable "dataproc_cluster_worker_num_local_ssds" {
  default     = 2
  type        = number
  description = "Number of localssds to attach to each worker node"
}

variable "dataproc_image_version" {
  default     = "2.0"
  type        = string
  description = "Dataproc image version"
}

#
# spark settings
#
variable "spark_driver_memory" {
  default     = "12G"
  type        = string
  description = "Amount of memory spark should allocate to spark driver"
}

variable "spark_executor_memory" {
  default     = "13G"
  type        = string
  description = "Amount of memory spark should allocate to each spark executor"
}

variable "spark_executor_cores" {
  default     = 5
  type        = number
  description = "Amount of cores spark should allocate to each spark executor"
}

variable "spark_executor_instances" {
  default     = 12
  type        = number
  description = "number of spark executor instances"
}

variable "spark_properties_override" {
  default     = ""
  type        = string
  description = "json blob of spark properties to override, if not set will use a default set of properties that should work for most use cases"
}

# GCS
#
variable "bucket_locations" {
  type        = string
  description = "Location for the gcs buckets, default is `US`"
  default     = "US"
}

# Misc
#
variable "project_id" {
  type        = string
  description = "project_id for resources to be deployed into"
}

variable "region" {
  type        = string
  description = "GCP region to deploy resources into"
}

variable "zone" {
  type        = string
  description = "GCP zone to deploy resources into"
}

variable "deployment_name" {
  type        = string
  description = "name to use as the base for all resources created. NOTE: if you change this it will recreate all resources"
}

variable "subnet_self_link" {
  type        = string
  description = "subnetwork self_link to deploy resources onto"
}

variable "labels" {
  default     = {}
  type        = map(string)
  description = "Labels to attach to created resources"
}

variable "force_destroy" {
  default     = false
  type        = bool
  description = "force destroy potentially persistent resources, like bigtable/gcs"
}

variable "tamr_license_key" {
  default     = ""
  type        = string
  description = "Set a tamr license key"
}

variable "tamr_instance_disk_type" {
  default     = "pd-ssd"
  type        = string
  description = "boot disk type"
}

variable "tamr_instance_disk_size" {
  default     = 100
  type        = number
  description = "size of the boot disk"
}
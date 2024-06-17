<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bigtable"></a> [bigtable](#module\_bigtable) | git::https://github.com/Datatamer/terraform-gcp-bigtable.git | v3.0.0 |
| <a name="module_cloud_sql"></a> [cloud\_sql](#module\_cloud\_sql) | git::https://github.com/Datatamer/terraform-gcp-tamr-cloud-sql.git | v6.1.0 |
| <a name="module_config"></a> [config](#module\_config) | git::https://github.com/Datatamer/terraform-gcp-tamr-config.git | v3.0.1 |
| <a name="module_gcs_buckets"></a> [gcs\_buckets](#module\_gcs\_buckets) | git::https://github.com/Datatamer/terraform-gcp-tamr-buckets.git | v3.0.0 |
| <a name="module_iam"></a> [iam](#module\_iam) | git::https://github.com/Datatamer/terraform-gcp-tamr-iam | v2.0.1 |
| <a name="module_tamr_vm"></a> [tamr\_vm](#module\_tamr\_vm) | git::https://github.com/Datatamer/terraform-gcp-tamr-vm.git | v2.2.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | name to use as the base for all resources created. NOTE: if you change this it will recreate all resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | project\_id for resources to be deployed into | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region to deploy resources into | `string` | n/a | yes |
| <a name="input_subnet_self_link"></a> [subnet\_self\_link](#input\_subnet\_self\_link) | subnetwork self\_link to deploy resources onto | `string` | n/a | yes |
| <a name="input_tamr_bigtable_max_nodes"></a> [tamr\_bigtable\_max\_nodes](#input\_tamr\_bigtable\_max\_nodes) | Max number of nodes to scale up to | `number` | n/a | yes |
| <a name="input_tamr_instance_image"></a> [tamr\_instance\_image](#input\_tamr\_instance\_image) | Image to use for Tamr VM boot disk | `string` | n/a | yes |
| <a name="input_tamr_instance_service_account"></a> [tamr\_instance\_service\_account](#input\_tamr\_instance\_service\_account) | email of service account to attach to the tamr instance. If not given will create a new service account for tamr to use. | `string` | n/a | yes |
| <a name="input_tamr_zip_uri"></a> [tamr\_zip\_uri](#input\_tamr\_zip\_uri) | gcs location to download tamr zip from | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone to deploy resources into | `string` | n/a | yes |
| <a name="input_additional_admin_users"></a> [additional\_admin\_users](#input\_additional\_admin\_users) | list of additional entities to give admin permissions to provisioned resources | `list(string)` | `[]` | no |
| <a name="input_additional_read_users"></a> [additional\_read\_users](#input\_additional\_read\_users) | list of additional entities to give read only permissions to provisioned resources | `list(string)` | `[]` | no |
| <a name="input_bucket_locations"></a> [bucket\_locations](#input\_bucket\_locations) | Location for the gcs buckets, default is `US` | `string` | `"US"` | no |
| <a name="input_dataproc_cluster_master_disk_size"></a> [dataproc\_cluster\_master\_disk\_size](#input\_dataproc\_cluster\_master\_disk\_size) | Size of disk to use on dataproc master disk | `number` | `1000` | no |
| <a name="input_dataproc_cluster_master_instance_type"></a> [dataproc\_cluster\_master\_instance\_type](#input\_dataproc\_cluster\_master\_instance\_type) | Instance type to use as dataproc master | `string` | `"n1-highmem-4"` | no |
| <a name="input_dataproc_cluster_worker_machine_type"></a> [dataproc\_cluster\_worker\_machine\_type](#input\_dataproc\_cluster\_worker\_machine\_type) | machine type of default worker pool | `string` | `"n1-standard-16"` | no |
| <a name="input_dataproc_cluster_worker_num_instances"></a> [dataproc\_cluster\_worker\_num\_instances](#input\_dataproc\_cluster\_worker\_num\_instances) | Number of default workers to use | `number` | `4` | no |
| <a name="input_dataproc_cluster_worker_num_local_ssds"></a> [dataproc\_cluster\_worker\_num\_local\_ssds](#input\_dataproc\_cluster\_worker\_num\_local\_ssds) | Number of localssds to attach to each worker node | `number` | `2` | no |
| <a name="input_dataproc_image_version"></a> [dataproc\_image\_version](#input\_dataproc\_image\_version) | Dataproc image version | `string` | `"2.0"` | no |
| <a name="input_dataproc_network_tags"></a> [dataproc\_network\_tags](#input\_dataproc\_network\_tags) | list of network tags to attach to each dataproc node | `list(string)` | `[]` | no |
| <a name="input_enable_cloud_sql_private_ip"></a> [enable\_cloud\_sql\_private\_ip](#input\_enable\_cloud\_sql\_private\_ip) | Whether the Cloud SQL instance should use a public or private ip address | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | force destroy potentially persistent resources, like bigtable/gcs | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to attach to created resources | `map(string)` | `{}` | no |
| <a name="input_pre_install_bash"></a> [pre\_install\_bash](#input\_pre\_install\_bash) | Bash to be run before Tamr is installed.<br>  Likely to be used to meet Tamr's prerequisites, if not already met by the image. (https://docs.tamr.com/new/docs/requirements )<br>   This will only be run once before Tamr is installed, unless Tamr fails to install. This bash will also be run on subsequent attempts to install Tamr, so it is recommended that this bash is idempotent. | `string` | `""` | no |
| <a name="input_private_network_id"></a> [private\_network\_id](#input\_private\_network\_id) | The VPC network from which the Cloud SQL instance is accessible for private IP | `string` | `""` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Set if SSL is required for the Cloud SQL instance. | `bool` | `false` | no |
| <a name="input_spark_driver_memory"></a> [spark\_driver\_memory](#input\_spark\_driver\_memory) | Amount of memory spark should allocate to spark driver | `string` | `"12G"` | no |
| <a name="input_spark_executor_cores"></a> [spark\_executor\_cores](#input\_spark\_executor\_cores) | Amount of cores spark should allocate to each spark executor | `number` | `5` | no |
| <a name="input_spark_executor_instances"></a> [spark\_executor\_instances](#input\_spark\_executor\_instances) | number of spark executor instances | `number` | `12` | no |
| <a name="input_spark_executor_memory"></a> [spark\_executor\_memory](#input\_spark\_executor\_memory) | Amount of memory spark should allocate to each spark executor | `string` | `"13G"` | no |
| <a name="input_spark_properties_override"></a> [spark\_properties\_override](#input\_spark\_properties\_override) | json blob of spark properties to override, if not set will use a default set of properties that should work for most use cases | `string` | `""` | no |
| <a name="input_sql_disk_size"></a> [sql\_disk\_size](#input\_sql\_disk\_size) | size of the disk to use on the tamr sql instance | `number` | `10` | no |
| <a name="input_sql_disk_type"></a> [sql\_disk\_type](#input\_sql\_disk\_type) | The disk type to use on the cloud SQL instance. should be either PD\_SSD or PD\_STANDARD | `string` | `"PD_SSD"` | no |
| <a name="input_sql_pg_version"></a> [sql\_pg\_version](#input\_sql\_pg\_version) | version of postgres to use on CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| <a name="input_sql_tier"></a> [sql\_tier](#input\_sql\_tier) | the machine type to use for the sql instance | `string` | `"db-custom-2-4096"` | no |
| <a name="input_ssl_mode"></a> [ssl\_mode](#input\_ssl\_mode) | Set up the SSL mode. If SSL is required, this value is TRUSTED\_CLIENT\_CERTIFICATE\_REQUIRED. | `string` | `"ALLOW_UNENCRYPTED_AND_ENCRYPTED"` | no |
| <a name="input_tamr_bigtable_min_nodes"></a> [tamr\_bigtable\_min\_nodes](#input\_tamr\_bigtable\_min\_nodes) | Min number of nodes to scale down to | `number` | `1` | no |
| <a name="input_tamr_cloud_sql_sslmode"></a> [tamr\_cloud\_sql\_sslmode](#input\_tamr\_cloud\_sql\_sslmode) | if ssl is disabled or not.Possible values include disable , allow , prefer , require , verify-ca and verify-full | `string` | `"disable"` | no |
| <a name="input_tamr_instance_disk_size"></a> [tamr\_instance\_disk\_size](#input\_tamr\_instance\_disk\_size) | size of the boot disk | `number` | `100` | no |
| <a name="input_tamr_instance_disk_type"></a> [tamr\_instance\_disk\_type](#input\_tamr\_instance\_disk\_type) | boot disk type | `string` | `"pd-ssd"` | no |
| <a name="input_tamr_instance_metadata"></a> [tamr\_instance\_metadata](#input\_tamr\_instance\_metadata) | custom metadata to attach to created VM | `map(string)` | `{}` | no |
| <a name="input_tamr_instance_tags"></a> [tamr\_instance\_tags](#input\_tamr\_instance\_tags) | list of network tags to attach to instance | `list(string)` | `[]` | no |
| <a name="input_tamr_license_key"></a> [tamr\_license\_key](#input\_tamr\_license\_key) | Set a tamr license key | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | An arbitrary value that changes each time the resource is replaced. |
| <a name="output_tamr_config_file"></a> [tamr\_config\_file](#output\_tamr\_config\_file) | full tamr config file |
| <a name="output_tamr_instance_self_link"></a> [tamr\_instance\_self\_link](#output\_tamr\_instance\_self\_link) | full self link of created tamr vm |
| <a name="output_tamr_service_account"></a> [tamr\_service\_account](#output\_tamr\_service\_account) | service account tamr is using |
| <a name="output_tmpl_dataproc_config"></a> [tmpl\_dataproc\_config](#output\_tmpl\_dataproc\_config) | dataproc config |
| <a name="output_tmpl_startup_script"></a> [tmpl\_startup\_script](#output\_tmpl\_startup\_script) | rendered metadata startup script |
<!-- END_TF_DOCS -->
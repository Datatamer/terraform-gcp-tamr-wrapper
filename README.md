# Tamr GCP Install Wrapper
This repo is meant to be a functioning example of how to wire all of the tamr gcp dependencies together to install tamr quickly. It does not support all of the options in each down stream module, as its meant to be slightly opinionated on how its used.

This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Minimal
Smallest complete fully working example
- [Minimal](https://github.com/Datatamer/terraform-gcp-tamr-wrapper/tree/master/examples/minimal)

# Resources Created
This modules creates:
* Initializes all of the child tamr gcp terraform modules for deploying a tamr gcp deployment
** bigtable instance
** gcs buckets
** gcp vm
** iam permissions

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 4.6.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deployment\_name | name to use as the base for all resources created. NOTE: if you change this it will recreate all resources | `string` | n/a | yes |
| project\_id | project\_id for resources to be deployed into | `string` | n/a | yes |
| region | GCP region to deploy resources into | `string` | n/a | yes |
| subnet\_self\_link | subnetwork self\_link to deploy resources onto | `string` | n/a | yes |
| tamr\_bigtable\_max\_nodes | Max number of nodes to scale up to | `number` | n/a | yes |
| tamr\_instance\_image | Image to use for Tamr VM boot disk | `string` | n/a | yes |
| tamr\_instance\_service\_account | email of service account to attach to the tamr instance. If not given will create a new service account for tamr to use. | `string` | n/a | yes |
| tamr\_zip\_uri | gcs location to download tamr zip from | `string` | n/a | yes |
| zone | GCP zone to deploy resources into | `string` | n/a | yes |
| additional\_admin\_users | list of additional entities to give admin permissions to provisioned resources | `list(string)` | `[]` | no |
| additional\_read\_users | list of additional entities to give read only permissions to provisioned resources | `list(string)` | `[]` | no |
| bucket\_locations | Location for the gcs buckets, default is `US` | `string` | `"US"` | no |
| dataproc\_cluster\_master\_disk\_size | Size of disk to use on dataproc master disk | `number` | `1000` | no |
| dataproc\_cluster\_master\_instance\_type | Instance type to use as dataproc master | `string` | `"n1-highmem-4"` | no |
| dataproc\_cluster\_worker\_machine\_type | machine type of default worker pool | `string` | `"n1-standard-16"` | no |
| dataproc\_cluster\_worker\_num\_instances | Number of default workers to use | `number` | `4` | no |
| dataproc\_cluster\_worker\_num\_local\_ssds | Number of localssds to attach to each worker node | `number` | `2` | no |
| dataproc\_image\_version | Dataproc image version | `string` | `"2.0"` | no |
| dataproc\_network\_tags | list of network tags to attach to each dataproc node | `list(string)` | `[]` | no |
| enable\_cloud\_sql\_private\_ip | Whether the Cloud SQL instance should use a public or private ip address | `bool` | `false` | no |
| force\_destroy | force destroy potentially persistent resources, like bigtable/gcs | `bool` | `false` | no |
| labels | Labels to attach to created resources | `map(string)` | `{}` | no |
| private\_network\_id | The VPC network from which the Cloud SQL instance is accessible for private IP | `string` | `""` | no |
| spark\_driver\_memory | Amount of memory spark should allocate to spark driver | `string` | `"12G"` | no |
| spark\_executor\_cores | Amount of cores spark should allocate to each spark executor | `number` | `5` | no |
| spark\_executor\_instances | number of spark executor instances | `number` | `12` | no |
| spark\_executor\_memory | Amount of memory spark should allocate to each spark executor | `string` | `"13G"` | no |
| spark\_properties\_override | json blob of spark properties to override, if not set will use a default set of properties that should work for most use cases | `string` | `""` | no |
| sql\_disk\_size | size of the disk to use on the tamr sql instance | `number` | `10` | no |
| sql\_disk\_type | The disk type to use on the cloud SQL instance. should be either PD\_SSD or PD\_STANDARD | `string` | `"PD_SSD"` | no |
| sql\_tier | the machine type to use for the sql instance | `string` | `"db-custom-2-4096"` | no |
| tamr\_bigtable\_min\_nodes | Min number of nodes to scale down to | `number` | `1` | no |
| tamr\_instance\_metadata | custom metadata to attach to created VM | `map(string)` | `{}` | no |
| tamr\_instance\_tags | list of network tags to attach to instance | `list(string)` | `[]` | no |
| tamr\_license\_key | Set a tamr license key | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ip | An arbitrary value that changes each time the resource is replaced. |
| tamr\_config\_file | full tamr config file |
| tamr\_instance\_self\_link | full self link of created tamr vm |
| tamr\_service\_account | service account tamr is using |
| tmpl\_dataproc\_config | dataproc config |
| tmpl\_startup\_script | rendered metadata startup script |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.

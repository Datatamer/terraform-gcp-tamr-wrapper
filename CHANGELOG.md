# GCP Tamr Wrapper

## v3.2.0 - April 25th 2023
* Following optional input variables now available
  * tamr_instance_metadata
* Allows flexibility for the user of this module to supply custom metadata for Tamr VM

## v3.2.0 - April 25th 2023
* Following optional input variables now available
  * tamr_license_key
* Allows flexibility for the user of this module to supply a Tamr license key

## v3.1.1 - April 21st 2023
* Use patched config module

## v3.1.0 - April 20th 2023
* Following optional input variables now available
  * tamr_instance_tags
  * dataproc_network_tags
* Allows flexibility for the user of this module to supply network tags to tamr_vm module and dataproc node

## v3.0.1 - April 7th 2023
* Use patched iam module

## v3.0.0 - April 6th 2023
* Following input variables now required
  * tamr_instance_service_account
* Allows flexibility for the user of this module to either create a new service account or use an existing one

## v2.1.1 - April 4th 2023
* uses https for source modules instead of ssh

## v2.1.0 - February 9th 2023
* exposes spark & dataproc settings from the Tamr configuration module

## v2.0.4 - August 12th 2022
* corrects IAM module version

## v2.0.3 - August 12th 2022
* updates patch versions of the config and IAM modules

## v2.0.2 - July 29th 2022
* update config version to v1.0.1

## v2.0.1 - July 29th 2022
* update config version

## v2.0.0 - July 21st 2022
* add config module
* renamed module output `tmpl_statup_script` to `tmpl_startup_script`

## v1.0.0 - June 1st 2022
* update minimum version of terraform to 1.0.0 and google provider to 4.6.0

## v0.5.2 - November 16th 2021
* Bump terraform-gcp-tamr-vm to update dataproc configuration

## v0.5.1 - November 16th 2021
* Bump terraform-gcp-tamr-iam version to include missing project variable

## v0.2.1 - August 3rd 2020
* Remove direct invocation of GLB module
* update docs with more examples

## v0.2.0 - July 31st 2020
* Adding integrations for GLB

## v0.1.0 - July 28th 2020
* Initing project

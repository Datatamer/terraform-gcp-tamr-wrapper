<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.29.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 3.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.29.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | ~> 3.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tamr_stack"></a> [tamr\_stack](#module\_tamr\_stack) | git::git@github.com:Datatamer/terraform-gcp-tamr-vm.git | v0.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_ssl_certificate.tamr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_certificate) | resource |
| [google-beta_google_secret_manager_secret_version.ssl_cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/google_secret_manager_secret_version) | data source |
| [google-beta_google_secret_manager_secret_version.ssl_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/google_secret_manager_secret_version) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
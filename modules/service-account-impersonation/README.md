# Google service account impersoantion for Terraform Cloud workspaces

This Terraform module grants permisison to impersonate a given service account by a Terraform workspace SA.

## Usage

```hcl
module "tfe-workspace-sa" {
  source  = "nephosolutions/tfe-workspace/google//modules/service-account"
  version = "2.0.0"

  # insert required variables.tf here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.52 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_service_account_iam_member.role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | The service which should be impersonated by the Terraform workspace. | `string` | n/a | yes |
| <a name="input_tfe_workspace_sa"></a> [tfe\_workspace\_sa](#input\_tfe\_workspace\_sa) | The Terraform workspace service account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

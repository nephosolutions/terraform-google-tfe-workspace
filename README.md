# Terraform Cloud workspace for Google Cloud deployments

This module provisions a Terraform Cloud workspace, a set of two Google service accounts and workspace variables.

A Terraform Workspace service account is used to authenticate the Terraform Cloud workspace to the Google APIs.
The Google service account key for that account is rotated every 30 days.

The workspace service account has only permissions granted which allows it to impersonate other service accounts.

## Usage

```hcl
module "tfe-workspace" {
  source  = "nephosolutions/tfe-workspace/google"
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
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.36 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service_account_impersonation"></a> [service\_account\_impersonation](#module\_service\_account\_impersonation) | ./modules/service-account-impersonation | n/a |
| <a name="module_tfe_workspace_sa"></a> [tfe\_workspace\_sa](#module\_tfe\_workspace\_sa) | ./modules/service-account | n/a |

## Resources

| Name | Type |
|------|------|
| [tfe_variable.google_default_region](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.google_default_zone](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.google_project_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfe_organization](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfe_workspace_sa](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfe_workspace_sa_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool_id"></a> [agent\_pool\_id](#input\_agent\_pool\_id) | The ID of an agent pool to assign to the workspace. | `string` | `null` | no |
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | Whether destroy plans can be queued on the workspace. | `bool` | `false` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the workspace. | `string` | n/a | yes |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Which execution mode to use. When set to `local`, the workspace will be used for state storage only. | `string` | `"remote"` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run. | `bool` | `false` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state (`remote_state_consumer_ids`). | `bool` | `false` | no |
| <a name="input_google_default_region"></a> [google\_default\_region](#input\_google\_default\_region) | The region used by default to create new resources | `string` | n/a | yes |
| <a name="input_google_default_zone"></a> [google\_default\_zone](#input\_google\_default\_zone) | The zone within a region used by default to create new resources | `string` | n/a | yes |
| <a name="input_google_project_id"></a> [google\_project\_id](#input\_google\_project\_id) | The Google Cloud Platform project ID | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the workspace. | `string` | n/a | yes |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | Whether the workspace should start automatically performing runs immediately after its creation. | `bool` | `true` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | The set of workspace IDs set as explicit remote state consumers for the given workspace. | `list(string)` | `[]` | no |
| <a name="input_service_accounts_to_impersonate"></a> [service\_accounts\_to\_impersonate](#input\_service\_accounts\_to\_impersonate) | A list of service accounts which the Terraform workspace SA can impersonate. | `list(string)` | `[]` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | Whether this workspace allows speculative plans.  Setting this to `false` prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors. | `bool` | `true` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | The ID of an SSH key to assign to the workspace. | `string` | `null` | no |
| <a name="input_structured_run_output_enabled"></a> [structured\_run\_output\_enabled](#input\_structured\_run\_output\_enabled) | Whether this workspace should show output from Terraform runs using the enhanced UI when available. Setting this to `false` ensures that all runs in this workspace will display their output as text logs. | `bool` | `true` | no |
| <a name="input_tag_names"></a> [tag\_names](#input\_tag\_names) | A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens. | `list(string)` | `[]` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to use for this workspace. This can be either an exact version or a version constraint (like `~> 1.0.0`); if you specify a constraint, the workspace will always use the newest release that meets that constraint. | `string` | n/a | yes |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | Name of the Terraform Cloud organization. | `string` | n/a | yes |
| <a name="input_tfe_workspace_sa_key_rotation_days"></a> [tfe\_workspace\_sa\_key\_rotation\_days](#input\_tfe\_workspace\_sa\_key\_rotation\_days) | Interval in days to rotate the workspace service account key. | `number` | `30` | no |
| <a name="input_trigger_patterns"></a> [trigger\_patterns](#input\_trigger\_patterns) | List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository. | `list(string)` | `null` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | List of repository-root-relative paths which describe all locations to be tracked for changes. | `list(string)` | `null` | no |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Settings for the workspace's VCS repository, enabling the UI/VCS-driven run workflow. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider. | <pre>object({<br>    identifier     = string<br>    oauth_token_id = string<br>  })</pre> | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within. Defaults to the root of your repository. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfe_workspace_sa"></a> [tfe\_workspace\_sa](#output\_tfe\_workspace\_sa) | The Google Cloud service account for the TFE workspace. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

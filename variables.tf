# Copyright 2022 NephoSolutions srl, Sebastian Trebitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "agent_pool_id" {
  default     = null
  description = "The ID of an agent pool to assign to the workspace."
  type        = string
}

variable "allow_destroy_plan" {
  description = "Whether destroy plans can be queued on the workspace."
  default     = false
  type        = bool
}

variable "auto_apply" {
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful."
  type        = bool
}

variable "description" {
  description = "A description for the workspace."
  type        = string
}

variable "execution_mode" {
  default     = "remote"
  description = "Which execution mode to use. When set to `local`, the workspace will be used for state storage only."
  type        = string

  validation {
    condition     = contains(["agent", "local", "remote"], var.execution_mode)
    error_message = "Using Terraform Cloud, valid values are `remote`, `local` or `agent`. Using Terraform Enterprise, only `remote` and `local` execution modes are valid."
  }
}

variable "file_triggers_enabled" {
  default     = false
  description = "Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run."
  type        = bool
}

variable "global_remote_state" {
  default     = false
  description = "Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state (`remote_state_consumer_ids`)."
  type        = bool
}

variable "google_default_region" {
  description = "The region used by default to create new resources"
  type        = string
}

variable "google_default_zone" {
  description = "The zone within a region used by default to create new resources"
  type        = string
}

variable "google_project_id" {
  description = "The Google Cloud Platform project ID"
  type        = string
}

variable "name" {
  description = "Name of the workspace."
  type        = string
}

variable "queue_all_runs" {
  default     = true
  description = "Whether the workspace should start automatically performing runs immediately after its creation."
  type        = bool
}

variable "remote_state_consumer_ids" {
  default     = []
  description = "The set of workspace IDs set as explicit remote state consumers for the given workspace."
  type        = list(string)
}

variable "speculative_enabled" {
  default     = true
  description = "Whether this workspace allows speculative plans.  Setting this to `false` prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors."
  type        = bool
}

variable "ssh_key_id" {
  default     = null
  description = "The ID of an SSH key to assign to the workspace."
  type        = string
}

variable "structured_run_output_enabled" {
  default     = true
  description = "Whether this workspace should show output from Terraform runs using the enhanced UI when available. Setting this to `false` ensures that all runs in this workspace will display their output as text logs."
  type        = bool
}

variable "tag_names" {
  default     = []
  description = "A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens."
  type        = list(string)
}

variable "terraform_version" {
  description = "The version of Terraform to use for this workspace. This can be either an exact version or a version constraint (like `~> 1.0.0`); if you specify a constraint, the workspace will always use the newest release that meets that constraint."
  type        = string
}

variable "tfe_organization_name" {
  description = "Name of the Terraform Cloud organization."
  type        = string
}

variable "tfe_workspace_sa_key_admins" {
  description = "List of Terraform workspace service account key admins."
  type        = list(string)
}

variable "tfe_workspace_sa_key_rotation_days" {
  default     = 30
  description = "Interval in days to rotate the workspace service account key."
  type        = number
}

variable "trigger_patterns" {
  default     = null
  description = "List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository."
  type        = list(string)
}

variable "trigger_prefixes" {
  default     = null
  description = "List of repository-root-relative paths which describe all locations to be tracked for changes."
  type        = list(string)
}

variable "vcs_repo" {
  default     = null
  description = "Settings for the workspace's VCS repository, enabling the UI/VCS-driven run workflow. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider."

  type = object({
    identifier     = string
    oauth_token_id = string
  })
}

variable "working_directory" {
  default     = null
  description = "A relative path that Terraform will execute within. Defaults to the root of your repository."
  type        = string
}

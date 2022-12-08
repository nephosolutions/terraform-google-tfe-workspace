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

module "tfe_workspace_sa" {
  source = "./modules/service-account"

  google_project_id                  = var.google_project_id
  tfe_workspace_id                   = tfe_workspace.workspace.id
  tfe_workspace_sa_key_rotation_days = var.tfe_workspace_sa_key_rotation_days
}

module "service_account_impersonation" {
  source   = "./modules/service-account-impersonation"
  for_each = toset(var.service_accounts_to_impersonate)

  service_account_id = each.key
  tfe_workspace_sa   = module.tfe_workspace_sa.tfe_workspace_sa
}
resource "tfe_variable" "google_default_region" {
  category     = "terraform"
  description  = "The region used by default to create new resources"
  key          = "google_default_region"
  value        = var.google_default_region
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "google_default_zone" {
  category     = "terraform"
  description  = "The zone within a region used by default to create new resources"
  key          = "google_default_zone"
  value        = var.google_default_zone
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "google_project_id" {
  category     = "terraform"
  description  = "The Google Cloud Platform project ID"
  key          = "google_project_id"
  value        = var.google_project_id
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tfe_organization" {
  category     = "terraform"
  description  = "The name of the organization."
  key          = "tfe_organization"
  value        = var.tfe_organization_name
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tfe_workspace_sa" {
  category     = "terraform"
  description  = "The Google Cloud service account for the TFE workspace."
  key          = "tfe_workspace_sa"
  value        = module.tfe_workspace_sa.tfe_workspace_sa
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tfe_workspace_sa_key" {
  category     = "terraform"
  description  = "The Google Cloud credentials for the TFE workspace service account in JSON format."
  key          = "tfe_workspace_sa_key"
  sensitive    = true
  value        = base64decode(module.tfe_workspace_sa.tfe_workspace_sa_key)
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_workspace" "workspace" {
  agent_pool_id                 = var.agent_pool_id
  allow_destroy_plan            = var.allow_destroy_plan
  auto_apply                    = var.auto_apply
  description                   = var.description
  execution_mode                = var.execution_mode
  file_triggers_enabled         = var.file_triggers_enabled
  global_remote_state           = var.global_remote_state
  name                          = var.name
  organization                  = var.tfe_organization_name
  queue_all_runs                = var.queue_all_runs
  remote_state_consumer_ids     = var.remote_state_consumer_ids
  speculative_enabled           = var.speculative_enabled
  ssh_key_id                    = var.ssh_key_id
  structured_run_output_enabled = var.structured_run_output_enabled
  tag_names                     = var.tag_names
  terraform_version             = var.terraform_version
  trigger_patterns              = var.trigger_patterns
  trigger_prefixes              = var.trigger_prefixes

  dynamic "vcs_repo" {
    for_each = var.vcs_repo == null ? [] : [1]

    content {
      identifier     = var.vcs_repo.identifier
      oauth_token_id = var.vcs_repo.oauth_token_id
    }
  }

  working_directory = var.working_directory
}

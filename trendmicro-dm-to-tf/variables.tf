variable "project_id" {
  type = string
  default = "tf-testing-357707"
}

variable "region" {
  description = "Default GCP region"
  default     = "asia-east1"
}

variable "zone" {
  description = "Default GCP zone"
  default     = "asia-east1-a"
}

variable "manager_service_account" {
  description = "Default manager_service_account"
  default     = "manger-service@tf-testing-357707.iam.gserviceaccount.com"
}

variable "deployment_name" {
  description = "Default deployment_name"
  default     = "trend-micro-fss"  
}

variable "gcp_services_list" {
  description = "Google APIs need to be enabled"
  type        = set(string)
  default     = [
    "cloudbuild.googleapis.com",
    "deploymentmanager.googleapis.com",
    "cloudfunctions.googleapis.com",
    "pubsub.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "iam.googleapis.com",
    "secretmanager.googleapis.com"
  ]
}

variable "gcp_custom_roles" {
  type = list(object({
    role_id = string
    description = string
    title = string
    permissions = set(string)
  }))
  default = [
    {
      role_id = "trend_micro_fss_bucket_listener_role"
      description = "Trend Micro File Storage Security trend micro bucket listener role"
      title = "trend-micro-fss-bucket-listener-role"
      permissions = [
        "iam.serviceAccounts.signBlob"
      ]
    },
    {
      role_id = "trend_micro_fss_post_action_tag_role"
      description = "Trend Micro File Storage Security trend micro post action tag role"
      title = "trend-micro-fss-post-action-tag-role"
      permissions = [
        "storage.objects.get",
        "storage.objects.update"
      ]
    },
    {
      role_id = "trend_micro_fss_cloud_function_management_role"
      description = "Trend Micro File Storage Security trend micro cloud function management role"
      title = "trend_micro_fss_cloud_function_management_role"
      permissions = [
        "cloudfunctions.functions.get",
        "cloudfunctions.functions.list",
        "cloudfunctions.functions.sourceCodeGet",
        "cloudfunctions.functions.sourceCodeSet",
        "cloudfunctions.functions.update",
        "cloudbuild.builds.get",
        "cloudbuild.builds.list"
      ]
    },
    {
      role_id = "trend_micro_fss_deployment_management_role"
      description = "Trend Micro File Storage Security trend micro deployment management role"
      title = "trend_micro_fss_deployment_management_role"
      permissions = [
        "deploymentmanager.deployments.get",
        "deploymentmanager.manifests.get"
      ]
    },
    {
      role_id = "trend_micro_fss_log_management_role"
      description = "Trend Micro File Storage Security trend micro log management role"
      title = "trend_micro_fss_log_management_role"
      permissions = [
        "logging.logs.list",
        "logging.queries.create",
        "logging.queries.get",
        "logging.queries.list"
      ]
    },
    {
      role_id = "trend_micro_fss_pubsub_iam_management_role"
      description = "Trend Micro File Storage Security trend micro pubsub iam management role"
      title = "trend_micro_fss_pubsub_iam_management_role"
      permissions = [
        "pubsub.topics.getIamPolicy",
        "pubsub.topics.setIamPolicy"
      ]
    },
    {
      role_id = "trend_micro_fss_pubsub_management_role"
      description = "Trend Micro File Storage Security trend micro pubsub management role"
      title = "trend_micro_fss_pubsub_management_role"
      permissions = [
        "pubsub.topics.get",
        "pubsub.topics.list",
        "pubsub.subscriptions.get",
        "pubsub.subscriptions.list"
      ]      
    },
    {
      role_id = "trend_micro_fss_secret_management_role"
      description = "Trend Micro File Storage Security trend micro secret management role"
      title = "trend_micro_fss_secret_management_role"
      permissions = [
        "secretmanager.secrets.get",
        "secretmanager.versions.add",
        "secretmanager.versions.enable",
        "secretmanager.versions.destroy",
        "secretmanager.versions.disable",
        "secretmanager.versions.get",
        "secretmanager.versions.list",
        "secretmanager.versions.access"
      ]        
    },
    {
      role_id = "trend_micro_fss_service_account_management_role"
      description = "Trend Micro File Storage Security trend micro service account management role"
      title = "trend_micro_fss_service_account_management_role"
      permissions = [
        "iam.serviceAccounts.get",
        "iam.serviceAccounts.getIamPolicy",
        "iam.serviceAccounts.list"
      ] 
    },
    {
      role_id = "trend_micro_fss_cloudservices_role"
      description = "Trend Micro File Storage Security trend micro Google APIs Service Agent role"
      title = "trend_micro_fss_cloudservices_role"
      permissions = [
        "cloudfunctions.functions.setIamPolicy",
        "iam.roles.create",
        "iam.serviceAccounts.setIamPolicy",
        "pubsub.topics.setIamPolicy",
        "resourcemanager.projects.setIamPolicy"
      ] 
    }
  ]
}


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

variable "trend_micro_fss_license" {
  description = "Default license string"
  default     = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJ3d3cudHJlbmRtaWNyby5jb20iLCJleHAiOjE2NjQ3Njk2MDAsIm5iZiI6MTY1NTM2NjU4NCwiaWF0IjoxNjU1MzY2NTg0LCJzdWIiOiJnY3AtcHJldmlldy1saWNlbnNlIiwiY2xvdWRPbmUiOnsiYWNjb3VudCI6IjU2NDUwNTA5NDE4NyJ9fQ.CaoPvyzly9C5izjmdCxjYmQZpKY8p4wleHGqtORmhpin6r9Ek5g8KyrPy2Q40LOzt0fKf680ZbCi7JROGJ4HTi-sJVX7uyKsn9y8NBGhNpBYQplKck5DibYltbUFUOI5bPubHN0tjwg5_JFiE7PfDYls8X_wDHLq1nxnHLz1jhzRXbNE-OR01faM_NdV2IqZTV_Px7O75VC7W6GaSFZ1jK0U4Yk0IjBQzn-KX3En2oeF16FmADSof2B_TkcYFKizGhoO1oohzEKEOEwfX3Nyx6-BvyNE7tmgR5YJUdUO8fLWZF0Io8Qjoh44xjrj2rpXvqN-1_q-anE_dh6LnBImTwvnzBZI1hZgNnB7REbwBZAlLhc0RjcbPAC6Fw16xgIebBHB0pz4T4QTDPt9pcm_efQxiXbg9DjQFN9DwkPKJSt6XvFJO5yhu3pFXjosHjPSbwL4evnW_11rvrxwjfPb-oK8MOjb2sImgokv5yL2E4JyxeQ7y4vIizUMkhrIhG_bpakdGgbHJm6kOuVBkUY5yKssnRIh--Bgdtb5bH69fYxoN1JKljiLW7KDKvxq1MsQOWH-u6tBaUzl85p6Ehd-DmtecsQFq0gzxTD28JalIvRsZ5-fVtR6o2Akp02Za4GeTUZep6iyLYC8SEBj3cAm2LVMcpvPm-6OAqhLyzZN4wE"
}

variable "trend_micro_fss_region" {
  description = "Default CloudOne Region"
  default     = "us-1"
}

variable "trend_micro_fss_account" {
  description = "Default CloudOne Account"
  default     = "manger-service@tf-testing-357707.iam.gserviceaccount.com"
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


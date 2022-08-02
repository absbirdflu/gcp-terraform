provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_project" "project" {}

/**
 Enable Google APIs
**/ 

resource "google_project_service" "gcp_services" {
  project  = var.project_id
  for_each = var.gcp_services_list
  service = each.value

  disable_dependent_services = true
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_bucket_listener_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_bucket_listener_role"
  description = "Trend Micro File Storage Security trend micro bucket listener role"
  title = "trend-micro-fss-bucket-listener-role"
  permissions = [
    "iam.serviceAccounts.signBlob"
  ]
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_post_action_tag_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_post_action_tag_role"
  description = "Trend Micro File Storage Security trend micro post action tag role"
  title = "trend-micro-fss-post-action-tag-role"
  permissions = [
    "storage.objects.get",
    "storage.objects.update"
  ]
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_cloud_function_management_role" {
  project  = var.project_id

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
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_deployment_management_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_deployment_management_role"
  description = "Trend Micro File Storage Security trend micro deployment management role"
  title = "trend_micro_fss_deployment_management_role"
  permissions = [
    "deploymentmanager.deployments.get",
    "deploymentmanager.manifests.get"
  ]
}

resource "google_project_iam_custom_role" "trend_micro_fss_log_management_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_log_management_role"
  description = "Trend Micro File Storage Security trend micro log management role"
  title = "trend_micro_fss_log_management_role"
  permissions = [
    "logging.logs.list",
    "logging.queries.create",
    "logging.queries.get",
    "logging.queries.list"
  ]
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_pubsub_iam_management_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_pubsub_iam_management_role"
  description = "Trend Micro File Storage Security trend micro pubsub iam management role"
  title = "trend_micro_fss_pubsub_iam_management_role"
  permissions = [
    "pubsub.topics.getIamPolicy",
    "pubsub.topics.setIamPolicy"
  ]
}

resource "google_project_iam_custom_role" "trend_micro_fss_pubsub_management_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_pubsub_management_role"
  description = "Trend Micro File Storage Security trend micro pubsub management role"
  title = "trend_micro_fss_pubsub_management_role"
  permissions = [
    "pubsub.topics.get",
    "pubsub.topics.list",
    "pubsub.subscriptions.get",
    "pubsub.subscriptions.list"
  ] 
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_secret_management_role" {
  project  = var.project_id

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
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_service_account_management_role" {
  project  = var.project_id

  role_id = "trend_micro_fss_service_account_management_role"
  description = "Trend Micro File Storage Security trend micro service account management role"
  title = "trend_micro_fss_service_account_management_role"
  permissions = [
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.list"
  ] 
}

/**
 Create the custom roles for trend micro fss
**/ 

resource "google_project_iam_custom_role" "trend_micro_fss_cloudservices_role" {
  project  = var.project_id

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

resource "google_project_iam_binding" "iam_binding_cloudservice_agent" {
  project = var.project_id
  role    = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_cloudservices_role.role_id}"

  members = [
    "serviceAccount:${data.google_project.project.number}@cloudservices.gserviceaccount.com",
  ]

  depends_on = [
    google_project_iam_custom_role.trend_micro_fss_cloudservices_role
  ]
}

/**
 Service Account for Scanner Cloud Function
**/ 

resource "google_service_account" "scanner_gcf_service_account" {
  account_id   = "${var.deployment_name}-scan-sa"
  display_name = "Service Account for Scanner Cloud Function"
}

resource "google_service_account_iam_binding" "scanner_gcf_service_account_iam" {
  service_account_id = google_service_account.scanner_gcf_service_account.name
  role               = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_service_account_management_role.role_id}"

  members = [
    "serviceAccount:${google_service_account.scanner_gcf_service_account.email}",
  ]
}

/**
 Service Account for Pattern Updater Function
**/ 

resource "google_service_account" "updater_gcf_service_account" {
  account_id   = "${var.deployment_name}-upd-sa"
  display_name = "Service Account for Pattern Updater Function"
}

resource "google_service_account_iam_binding" "updater_gcf_service_account_iam" {
  service_account_id = google_service_account.updater_gcf_service_account.name
  role               = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_service_account_management_role.role_id}"

  members = [
    "serviceAccount:${google_service_account.updater_gcf_service_account.email}",
  ]
}

/**
 Create Scanner Topic
**/

resource "google_pubsub_topic" "scanner_topic" {
  name = "${var.deployment_name}-scanner-topic"

  depends_on = [
    google_service_account.scanner_gcf_service_account
  ]
}

data "google_iam_policy" "scanner_topic_iam_policy" {
  binding {
    role = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_pubsub_management_role.role_id}"
    members = [
      "serviceAccount:${var.manager_service_account}"
    ]
  }
  binding {
    role = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_pubsub_iam_management_role.role_id}"
    members = [
      "serviceAccount:${var.manager_service_account}"
    ]
  }
  binding {
    role = "roles/pubsub.publisher"
    members = [
      "serviceAccount:${google_service_account.scanner_gcf_service_account.email}",
    ]
  }
}

resource "google_pubsub_topic_iam_policy" "scanner_deploy_scanner_topic_policy" {
  topic          = google_pubsub_topic.scanner_topic.name
  policy_data    = data.google_iam_policy.scanner_topic_iam_policy.policy_data

  depends_on = [
    google_pubsub_topic.scanner_topic
  ]
}

/**
 Create Scanner Topic DLT
**/

resource "google_pubsub_topic" "scanner_topic_dlt" {
  name = "${var.deployment_name}-scanner-topic-dlt"
}

data "google_iam_policy" "scanner_topic_dlt_iam_policy" {
  binding {
    role = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_pubsub_management_role.role_id}"
    members = [
      "serviceAccount:${var.manager_service_account}"
    ]
  }
  binding {
    role = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_pubsub_iam_management_role.role_id}"
    members = [
      "serviceAccount:${var.manager_service_account}"
    ]
  }
  binding {
    role = "roles/pubsub.publisher"
    members = [
      "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    ]
  }
}

resource "google_pubsub_topic_iam_policy" "scanner_topic_dlt_policy" {
  topic          = google_pubsub_topic.scanner_topic_dlt.name
  policy_data    = data.google_iam_policy.scanner_topic_dlt_iam_policy.policy_data

  depends_on = [
    google_pubsub_topic.scanner_topic_dlt
  ]
}

/** 
TO-DO: SECRET_STRING & Secrets manager

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret-version"

  labels = {
    label = "my-label"
  }

  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = "secret-data"
}
**/ 

/** 
TO-DO: Allow scanner service and manager service account to access the secrets

data "google_iam_policy" "admin" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = [
      "user:jane@example.com",
    ]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  project = google_secret_manager_secret.secret-basic.project
  secret_id = google_secret_manager_secret.secret-basic.secret_id
  policy_data = data.google_iam_policy.admin.policy_data
}
**/ 

/** 
TO-DO: Deploy Scanner function
 
resource "google_cloudfunctions_function" "scanner_function" {

  depends_on = [
    google_pubsub_topic.scanner_deploy_scanner_topic,
    google_service_account.scanner_deploy_scanner_service_account
  ]
}
**/

/** 
TO-DO: Deploy Scanner DLT function


resource "google_cloudfunctions_function" "scanner_dlt_function" {

  depends_on = [
    google_pubsub_topic.scanner_topic_dlt,
    google_service_account.scanner_gcf_service_account
  ]
}
**/

/**
resource "google_project_iam_custom_role" "trend_micro_fss_roles" {
  project  = var.project_id
  for_each = toset(keys({for i, r in var.gcp_custom_roles:  i => r}))

  role_id     = var.gcp_custom_roles[each.value]["role_id"]
  title       = var.gcp_custom_roles[each.value]["title"]
  description = var.gcp_custom_roles[each.value]["description"]
  permissions = var.gcp_custom_roles[each.value]["permissions"]
}
**/


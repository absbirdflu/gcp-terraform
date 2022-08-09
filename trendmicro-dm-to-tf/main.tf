provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_project" "project" {}

resource "null_resource" "gcp_scanner" {
  provisioner "local-exec" {
    command = "curl https://file-storage-security.s3.amazonaws.com/latest/cloud-functions/gcp-scanner.zip --output gcp-scanner.zip"
  }
}

resource "null_resource" "gcp_scanner_dlt" {
  provisioner "local-exec" {
    command = "curl https://file-storage-security.s3.amazonaws.com/latest/cloud-functions/gcp-scanner-dlt.zip --output gcp-scanner-dlt.zip"
  }
}

resource "null_resource" "gcp_scanner_pattern_updater" {
  provisioner "local-exec" {
    command = "curl https://file-storage-security.s3.amazonaws.com/latest/cloud-functions/gcp-scanner-pattern-updater.zip --output gcp-scanner-pattern-updater.zip"
  }
}


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
    "serviceAccount:${google_service_account.scanner_gcf_service_account.email}"
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
    "serviceAccount:${google_service_account.updater_gcf_service_account.email}"
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
      "serviceAccount:${google_service_account.scanner_gcf_service_account.email}"
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
SECRET_STRING & Secrets manager
**/ 
resource "google_secret_manager_secret" "trend_micro_fss_secret" {
  secret_id = "${var.deployment_name}-scanner-secrets"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  depends_on = [
    google_project_service.gcp_services
  ]
}

resource "google_secret_manager_secret_version" "trend_micro_fss_secret_version" {
  secret = google_secret_manager_secret.trend_micro_fss_secret.id

  secret_data = jsonencode({
    LICENSE = var.trend_micro_fss_license
    FSS_API_ENDPOINT = "https://filestorage.${var.trend_micro_fss_region}.cloudone.trendmicro.com/api/"
    LICENSE_SUBJECT = "gcp-preview-license"
    CLOUD_ONE_ACCOUNT = var.trend_micro_fss_account
  })

  depends_on = [
    google_secret_manager_secret.trend_micro_fss_secret
  ]
}

/** 
Allow scanner service and manager service account to access the secrets
**/
resource "google_secret_manager_secret_iam_binding" "scanner_gcf_service_account_secret_iam_binding" {
  project = google_secret_manager_secret.trend_micro_fss_secret.project
  secret_id = google_secret_manager_secret.trend_micro_fss_secret.secret_id
  role = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.scanner_gcf_service_account.email}"
  ]

  depends_on = [
    google_project_service.gcp_services,
    google_secret_manager_secret.trend_micro_fss_secret,
    google_service_account.scanner_gcf_service_account
  ]
}

resource "google_secret_manager_secret_iam_binding" "manager_service_account_secret_iam_binding" {
  project = google_secret_manager_secret.trend_micro_fss_secret.project
  secret_id = google_secret_manager_secret.trend_micro_fss_secret.secret_id
  role    = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.trend_micro_fss_secret_management_role.role_id}"
  members = [
    "serviceAccount:${var.manager_service_account}"
  ]

  depends_on = [
    google_project_service.gcp_services,
    google_secret_manager_secret.trend_micro_fss_secret
  ]
}
 

/** 
TO-DO: Deploy Scanner function
**/

resource "google_storage_bucket" "function_bucket" {
    name     = "${var.project_id}-function"
    location = var.region
}

/**
data "archive_file" "gcp_scanner_source" {
    type        = "zip"
    source_file = "gcp-scanner.zip"
    output_path = "gcp-scanner.zip"

  depends_on = [
    null_resource.gcp_scanner
  ]
}

data "archive_file" "gcp_scanner_dlt_source" {
    type        = "zip"
    source_file = "gcp-scanner-dlt.zip"
    output_path = "gcp-scanner-dlt.zip"

  depends_on = [
    null_resource.gcp_scanner_dlt
  ]
}

data "archive_file" "gcp_scanner_pattern_updater_source" {
    type        = "zip"
    source_file = "gcp-scanner-pattern-updater.zip"
    output_path = "gcp-scanner-pattern-updater.zip"

  depends_on = [
    null_resource.gcp_scanner_pattern_updater
  ]
}
**/

resource "google_storage_bucket_object" "gcp_scanner_source_zip" {
    source       = "gcp-scanner.zip"
    content_type = "application/zip"

    name         = "src-gcp-scanner.zip"
    bucket       = google_storage_bucket.function_bucket.name

    depends_on   = [
        google_storage_bucket.function_bucket
    ]
}

resource "google_storage_bucket_object" "gcp_scanner_dlt_source_zip" {
    source       = "gcp-scanner-dlt.zip"
    content_type = "application/zip"

    name         = "src-gcp-scanner-dlt.zip"
    bucket       = google_storage_bucket.function_bucket.name

    depends_on   = [
        google_storage_bucket.function_bucket
    ]
}

resource "google_storage_bucket_object" "gcp_scanner_pattern_updater_source_zip" {
    source       = "gcp-scanner-pattern-updater.zip"
    content_type = "application/zip"

    name         = "src-gcp-scanner-pattern-updater.zip"
    bucket       = google_storage_bucket.function_bucket.name

    depends_on   = [
        google_storage_bucket.function_bucket
    ]
}
 
resource "google_cloudfunctions_function" "scanner_function" {

  name = "${var.deployment_name}-scanner"

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.gcp_scanner_source_zip.name

  entry_point = "main"
  runtime = "python38"
  available_memory_mb = 2048
  service_account_email = google_service_account.scanner_gcf_service_account.email
  timeout = 120
  region = var.region

  environment_variables = {
    "DEPLOYMENT_NAME" = var.deployment_name
    "LD_LIBRARY_PATH" = "/workspace:/workspace/lib"
    "PATTERN_PATH" = "./patterns"
    "PROJECT_ID" = var.project_id
    "REGION" = var.region
  }

  secret_environment_variables {
    key = "SCANNER_SECRETS"
    project_id = google_secret_manager_secret.trend_micro_fss_secret.project
    secret = google_secret_manager_secret.trend_micro_fss_secret.secret_id
    version = "1"
  }

  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource = google_pubsub_topic.scanner_topic.name
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }

  depends_on = [
    google_storage_bucket_object.gcp_scanner_source_zip,
    google_pubsub_topic.scanner_topic,
    google_service_account.scanner_gcf_service_account,
    google_secret_manager_secret_version.trend_micro_fss_secret_version,
    google_secret_manager_secret_iam_binding.scanner_gcf_service_account_secret_iam_binding
  ]
}


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


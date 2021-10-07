variable "project_id" {
  type = string
  default = "andychentw-gcp-lab"
}

variable "region" {
  description = "Default GCP region"
  default     = "asia-east1"
}

variable "zone" {
  description = "Default GCP zone"
  default     = "asia-east1-a"
}

variable "ip_range" {
  description = "Default subnetwork IP range"
  default     = "10.140.0.0/20"
}


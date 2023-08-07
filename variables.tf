variable "kubeconfig_location" {
  type        = string
  description = "Path to the kube config file"
}

variable "gke_service_name" {
  type = string
}

variable "gke_service_target_http_port" {}

variable "app_cert_filepath" {
  type        = string
  description = "Path to the SSL certificate to be used by the application"
}

variable "app_cert_pk_filepath" {
  type        = string
  description = "Path to the Private Key related to the SSL certificate"
}

variable "application_replicas_count" {
  description = "Number of replicas to create for the application"
}
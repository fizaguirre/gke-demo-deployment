variable "kubeconfig_location" {
  type = string
}

variable "gke_service_name" {
  type = string
}

variable "gke_service_target_http_port" {}

variable "app_cert_filepath" {
  type = string
}

variable "app_cert_pk_filepath" {
  type = string
}
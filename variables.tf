variable "gke_service_name" {
  type = string
}

variable "gke_service_target_http_port" {}

variable "ssl_certificate" {
  description = "SSL Certificate to be used by the Load Balancer"  
}

variable "rsa_private_key" {
  description = "RSA Private Key that belongs to the SSL Certificate used by this module"  
}

variable "application_replicas_count" {
  description = "Number of replicas to create for the application"
}
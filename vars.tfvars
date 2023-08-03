kubeconfig_location          = "~/.kube/config"
gke_service_name             = "appsvc"
gke_service_target_http_port = 8080
app_cert_filepath            = "../shared-outputs/app.crt"
app_cert_pk_filepath         = "../shared-outputs/app.key"
application_replicas_count   = 3
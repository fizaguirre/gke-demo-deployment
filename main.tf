resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name = "dokuwiki"
  }
  spec {
    selector {
      match_labels = { "app" = "dokuwiki" }
    }
    replicas = "1"
    template {
      metadata {
        labels = { "app" = "dokuwiki" }
      }
      spec {
        container {
          image = "bitnami/dokuwiki"
          name  = "dokuwiki"
          port {
            container_port = var.gke_service_target_http_port
            protocol       = "TCP"
          }
          port {
            container_port = 8443
            protocol       = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name = var.gke_service_name
  }
  spec {
    selector = { "app" = "dokuwiki" }
    type     = "NodePort"
    port {
      port        = var.gke_service_target_http_port
      protocol    = "TCP"
      target_port = var.gke_service_target_http_port
    }
  }
}

resource "kubernetes_secret" "app_cert" {
  metadata {
    name = "app-cert-secret"
  }
  data = { "tls.crt" = file(var.app_cert_filepath), "tls.key" = file(var.app_cert_pk_filepath) }
}

resource "kubernetes_ingress_v1" "app_ingress_lb" {
  metadata {
    name = "appingresslb"
  }
  spec {
    default_backend {
      service {
        name = var.gke_service_name
        port {
          number = var.gke_service_target_http_port
        }
      }
    }
    tls {
      secret_name = kubernetes_secret.app_cert.metadata[0].name
    }
  }
}
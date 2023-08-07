resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name = "dokuwiki"
  }
  spec {
    selector {
      match_labels = { "app" = "dokuwiki" }
    }
    replicas = var.application_replicas_count
    template {
      metadata {
        labels = { "app" = "dokuwiki" }
      }
      spec {
        volume {
          name = "data"
          empty_dir {

          }
        }
        container {
          image = "bitnami/dokuwiki"
          name  = "dokuwiki"
          volume_mount {
            name       = "data"
            mount_path = "/bitnami/dokuwiki/"
          }
          port {
            container_port = var.gke_service_target_http_port
            protocol       = "TCP"
          }
          port {
            container_port = 8443
            protocol       = "TCP"
          }
        }
        container {
          image = "alpine"
          name  = "node-info"
          env {
            name  = "DOKUWIKI_PAGES_PATH"
            value = "/bitnami/dokuwiki/data/pages/wiki"
          }
          command = ["/bin/sh", "-c", "while [ true ]; do if [ -d $DOKUWIKI_PAGES_PATH ]; then echo \"Hostname: $HOSTNAME\" > $DOKUWIKI_PAGES_PATH/node.txt; sleep 1200; fi done"]
          volume_mount {
            name       = "data"
            mount_path = "/bitnami/dokuwiki/"
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
  data = { "tls.crt" = file(abspath(var.app_cert_filepath)), "tls.key" = file(abspath(var.app_cert_pk_filepath)) }
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
  wait_for_load_balancer = true
}

output "app_endpoint" {
  value       = "https://${kubernetes_ingress_v1.app_ingress_lb.status[0].load_balancer[0].ingress[0].ip}/"
  description = "Application external endpoint"
}
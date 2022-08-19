resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "${var.customer}-${var.project}-${var.env}-scalable-nginx"
    labels = {
      App = "ScalableNginx"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginx"
        }
      }
      spec {
        container {
          image = "nginx:${var.nginx_version}"
          name  = "nginx"

          port {
            container_port = var.nginx_port
          }

          resources {
            limits = {
              cpu    = var.nginx_cpu_limit
              memory = var.nginx_mem_limit
            }
            requests = {
              cpu    = var.nginx_cpu_request
              memory = var.nginx_mem_request
            }
          }
        }
      }
    }
  }
}

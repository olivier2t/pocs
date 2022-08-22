resource "kubernetes_service" "nginx" {
  metadata {
    name = "${var.customer}-${var.project}-${var.env}-scalable-nginx"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = var.nginx_port
      target_port = var.nginx_port
    }

    type = "LoadBalancer"
  }
}
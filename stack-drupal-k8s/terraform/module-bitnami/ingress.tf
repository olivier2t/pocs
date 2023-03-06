# resource "kubernetes_ingress" "harbor" {
#   metadata {
#     name      = "${var.project}-harbor"
#     namespace = var.namespace
#     labels    = {
#       "app.kubernetes.io/name"       = "${var.project}-web"
#       "app.kubernetes.io/managed-by" = "terraform"
#       project                        = var.project
#       env                            = var.env
#     }
#   }

#   spec {
#     rule {
#       host = local.k8s_frontend_host

#       http {
#         path {
#           backend {
#             service_name = kubernetes_service.web.metadata.0.name
#             service_port = "http"
#           }

#           path = "/"
#         }
#       }
#     }

#     tls {
#       secret_name = var.ssl_secret_name
#     }
#   }
# }
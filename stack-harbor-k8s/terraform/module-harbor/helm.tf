data "kubernetes_namespace" "harbor" {
  metadata {
    name = var.k8s_namespace
  }
}

resource "helm_release" "harbor" {
  name       = "${var.project}-harbor"
  repository = "https://helm.goharbor.io/harbor"
  chart      = "harbor"
  version    = "v1.10.4"
  namespace  = data.kubernetes_namespace.harbor.metadata.0.name
  wait       = true
  timeout    = 600

  values = [
    file("${path.module}/values.yaml")
  ]

  # Override some parameters. Description at https://github.com/goharbor/harbor-helm
  set {
    name  = "expose.tls.enabled"
    value = "false"
  }

  set {
    name  = "internalTLS.enabled"
    value = "false"
  }

  set {
    name  = "persistence.enabled"
    value = "false"
  }

  set {
    name  = "trivy.enabled"
    value = "false"
  }

  set {
    name  = "database.type"
    value = "external"
  }

  set {
    name  = "database.external.host"
    value = var.database_host
  }

  set {
    name  = "database.external.port"
    value = var.database_port
  }

  set {
    name  = "database.external.username"
    value = var.database_username
  }

  set {
    name  = "database.external.password"
    value = var.database_password
  }

  set {
    name  = "database.external.coreDatabase"
    value = var.database_core_name
  }
}
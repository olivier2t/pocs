resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.eks_namespace
  }
}

resource "helm_release" "harbor" {
  name       = "harbor"
  repository = "https://helm.goharbor.io"
  chart      = "harbor/harbor"

  namespace  = kubernetes_namespace.harbor.metadata.0.name
  wait       = true
  timeout    = 600

  # Parameters description at https://github.com/goharbor/harbor-helm
  set {
    name  = "expose.type"
    value = "NodePort"
  }

  set {
    name  = "expose.tls.enabled"
    value = "false"
  }

  set {
    name  = "persistence.enabled"
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
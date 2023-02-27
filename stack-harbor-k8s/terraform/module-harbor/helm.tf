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
    value = split(":", var.database_cluster.endpoint)[0]
  }

  set {
    name  = "database.external.port"
    value = split(":", var.database_cluster.endpoint)[1]
  }

  set {
    name  = "database.external.username"
    value = var.database_cluster.username
  }

  set {
    name  = "database.external.password"
    value = var.database_cluster.password
  }

  set {
    name  = "database.external.coreDatabase"
    value = var.database_coreDatabase
  }

  set {
    name  = "database.external.notaryServerDatabase"
    value = var.database_notaryServerDatabase
  }

  set {
    name  = "database.external.notarySignerDatabase"
    value = var.database_notarySignerDatabase
  }
}
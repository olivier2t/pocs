data "kubernetes_namespace" "harbor" {
  metadata {
    name = var.k8s_namespace
  }
}

resource "helm_release" "harbor" {
  name       = "${var.project}-harbor"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "drupal"
  version    = "12.5.13"
  namespace  = data.kubernetes_namespace.harbor.metadata.0.name
  wait       = true
  timeout    = 600

  values = [
    file("${path.module}/values.yaml")
  ]

  # Override some parameters. Description at https://github.com/bitnami/charts/tree/main/bitnami/drupal
  set {
    name  = "mariadb.enabled"
    value = "false"
  }

  set {
    name  = "externalDatabase.host"
    value = split(":", var.database_cluster.endpoint)[0]
  }

  set {
    name  = "externalDatabase.port"
    value = split(":", var.database_cluster.endpoint)[1]
  }

  set {
    name  = "externalDatabase.user"
    value = var.database_cluster.username
  }

  set {
    name  = "externalDatabase.password"
    value = var.database_cluster.password
  }

  set {
    name  = "externalDatabase.database"
    value = var.database_name
  }
}
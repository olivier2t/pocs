provider "kubernetes" {
  host                   = var.k8s_cluster.host
  cluster_ca_certificate = base64decode(var.k8s_cluster.cluster_ca_certificate)
  token                  = var.k8s_cluster.token
}

provider "helm" {
  host                   = var.k8s_cluster.host
  cluster_ca_certificate = base64decode(var.k8s_cluster.cluster_ca_certificate)
  token                  = var.k8s_cluster.token
}
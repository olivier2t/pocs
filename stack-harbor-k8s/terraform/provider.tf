provider "kubernetes" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  token                  = var.k8s_token
}

provider "helm" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  token                  = var.k8s_token
}
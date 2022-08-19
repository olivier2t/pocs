module "nginx" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-nginx"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
  }

  #. nginx_version: "1.7.8"
  #+ Version of NGINX to deploy
  nginx_version = "1.7.8"

  #. nginx_port: "80"
  #+ Port where NGINX service is exposed
  nginx_port = "80"

  #. nginx_cpu_limit: "0.5"
  #+ CPU resource limit for the deployment
  nginx_cpu_limit = "0.5"

  #. nginx_mem_limit: "512Mi"
  #+ Memory resource limit for the deployment
  nginx_mem_limit = "512Mi"

  #. nginx_cpu_request: "250m"
  #+ CPU resource request for the deployment
  nginx_cpu_request = "250m"

  #. nginx_mem_request: "50Mi"
  #+ Memory resource request for the deployment
  nginx_mem_request = "50Mi"
}
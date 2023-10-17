module "vpc" {
  #####################################
  # Do not modify the following lines #
  source = "terraform-aws-modules/vpc/aws"
  #####################################

  #. cidr: "10.0.0.0/16"
  #+ The CIDR of the VPC to create
  cidr = var.vpc_cidr

  name = "${var.customer}-${var.project}-${var.env}"
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)

  private_subnets  = local.private_subnets
  public_subnets   = local.public_subnets
  database_subnets = local.database_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name     = "${var.customer}-${var.project}-${var.env}"
    role     = "vpc"
    customer = var.customer
    project  = var.project
    env      = var.env
  }
}

module "bastion" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-bastion"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    monitoring_discovery = true
  }

  #. bastion: false
  #+ Whether to deploy a bastion host or not
  bastion = false

  #. bastion_instance_type: "t3.micro"
  #+ Instance type for the bastion
  bastion_instance_type = "t3.micro"

  #. keypair_public: ""
  #+ The public SSH key, for SSH access to newly-created instances
  keypair_public = var.keypair_public

  #. subnet_id: ''
  #+ Subnet ID where to deploy the EC2 instance
  subnet_id = module.vpc.public_subnets[0]
}

module "database" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-database"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }

  vpc_id                     = module.vpc.vpc_id
  database_subnet_group_name = module.vpc.database_subnet_group_name

  # MySQL RDS

  #. rds_mysql_instance_class: "db.t3.small"
  #+ MySQL RDS instance type
  rds_mysql_instance_class = "db.t3.small"

  #. rds_mysql_allocated_storage: 5
  #+ MySQL RDS disk size (Go)
  rds_mysql_allocated_storage = 5

  #. rds_mysql_max_allocated_storage: 100
  #+ MySQL RDS max disk size (Go). 0 disables Storage Autoscaling.
  rds_mysql_max_allocated_storage = 100

  #. rds_mysql_multiaz: true
  #+ Whether to enable RDS MySQL Multi-AZ mode or not.
  rds_mysql_multiaz = true

  # PostgreSQL RDS

  #. rds_postgres_instance_class: "db.t3.micro"
  #+ PostgreSQL RDS instance type
  rds_postgres_instance_class = "db.t3.micro"

  #. rds_postgres_allocated_storage: 5
  #+ PostgreSQL RDS disk size (Go)
  rds_postgres_allocated_storage = 5

  #. rds_postgres_max_allocated_storage: 100
  #+ PostgreSQL RDS max disk size (Go). 0 disables Storage Autoscaling.
  rds_postgres_max_allocated_storage = 100

  #. rds_postgres_multiaz: true
  #+ Whether to enable RDS PostgreSQL Multi-AZ mode or not.
  rds_postgres_multiaz = true

  # ElasticSearch Server

  #. es_instance_type: ""
  #+ The instance type for the ElasticSearch server
  es_instance_type = "t3a.large"

  #. es_disk_size: ""
  #+ The EBS disk size for the ElasticSearch data
  es_disk_size = 30

  #. es_keypair_public: ""
  #+ The public SSH key, for SSH access to newly-created instances
  es_keypair_public = var.keypair_public

  # Networking

  #. subnet_ids: []
  #+ List of subnets where to deploy RDS instances and ES server.
  subnet_ids = module.vpc.database_subnets

  cycloid_sg_id = module.core.cycloid_sg_id
}

module "core" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-core"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }

  #. vpc_id: ""
  #+ The ID of the VPC
  vpc_id = module.vpc.vpc_id

  keypair_public = var.keypair_public

  #. subnet_ids: ''
  #+ The subnet IDs list where to deploy the Cycloid core servers
  subnet_ids = module.vpc.private_subnets

  #. trusted_cidr_blocks: []
  #+ A list of trusted external IP to allow connection from.
  trusted_cidr_blocks = var.vpc_cidr

  #. core_instance_type: "t3a.medium"
  #+ Instance type for the Cycloid Core servers
  core_instance_type = "t3a.medium"

  #. core_volume_size: 30
  #+ Volume size for the Cycloid Core servers
  core_volume_size = 30

  #. core_hosted_zone: "cycloid.io"
  #+ The domain of the hosted zone
  core_hosted_zone = "cycloid.io"

  #. core_domain_console: "console2"
  #+ The Cycloid console subdomain of the hosted zone domain. This is used to access Cycloid console
  core_domain_console = "console2"

  #. core_domain_api: "api2"
  #+ The Cycloid API subdomain of the hosted zone domain. This is used to access Cycloid API
  core_domain_api = "api2"

  #. core_domain_concourse: "scheduler2"
  #+ The Concourse subdomain of the hosted zone domain. This is used by the Concourse workers to connect to Cycloid backend
  core_domain_concourse = "scheduler2"

  #. key_name: ''
  #+ The SSH public key name to provision to EC2 servers
  key_name = module.database.key_name
}

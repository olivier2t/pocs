resource "random_password" "password" {
  length = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# resource "aws_security_group" "pgsql" {
#   vpc_id      = var.vpc_id
#   name        = "pgsql"
#   description = "Allow all inbound for PostgreSQL"
#   ingress {
#     from_port   = 5432
#     to_port     = 5433
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # cidr_blocks = [var.vpc_public_subnets]
#   }
# }

resource "aws_db_instance" "rds" {
  identifier             = "rds-${var.rds_engine}-${var.customer}-${var.project}-${var.env}"
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  engine                 = var.rds_engine
  username               = var.rds_username
  password               = random_password.password.result
  db_name                = var.rds_database_name
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  availability_zone      = var.vpc_azs[0]
  publicly_accessible    = true
  skip_final_snapshot    = true
  apply_immediately      = true

  tags = merge(local.merged_tags, {
    Name        = "rds-${var.rds_engine}-${var.customer}-${var.project}-${var.env}"
    Environment = var.env
    role        = "rds"
  })
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.customer}-${var.project}-${var.env}-subnetgroup"
  subnet_ids = var.vpc_public_subnets

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-subnetgroup"
    role       = "subnetgroup"
  })
}

# resource "aws_rds_cluster" "rds" {
#   cluster_identifier      = "rds-${var.rds_engine}-${var.customer}-${var.project}-${var.env}"
#   engine                  = var.rds_engine
#   engine_version          = var.rds_engine_version
#   availability_zones      = var.vpc_azs
#   database_name           = var.rds_database_name
#   master_username         = var.rds_username
#   master_password         = random_password.password.result
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
# }

# module "rds" {
#   source  = "terraform-aws-modules/rds-aurora/aws"

#   name              = "rds-${var.rds_engine}-${var.customer}-${var.project}-${var.env}"
#   engine            = var.rds_engine
#   engine_version    = var.rds_engine_version

#   vpc_id                  = var.vpc_id
#   subnets                 = var.vpc_private_subnets
#   publicly_accessible     = true
#   allowed_security_groups = [aws_security_group.pgsql.id]

#   master_username        = var.rds_username
#   master_password        = random_password.password.result
#   create_random_password = false
#   database_name          = var.rds_database_name

#   # Multi-AZ
#   availability_zones        = var.vpc_azs
#   allocated_storage         = var.rds_allocated_storage
#   db_cluster_instance_class = var.rds_db_cluster_instance_class
#   iops                      = var.rds_iops
#   storage_type              = "io1"

#   storage_encrypted   = true
#   apply_immediately   = true
#   skip_final_snapshot = true

#   tags = merge(local.merged_tags, {
#     Name        = "rds-${var.rds_engine}-${var.customer}-${var.project}-${var.env}"
#     Environment = var.env
#     role        = "rds"
#   }
# }

# # Equivalent SQL:
# #
# #     CREATE ROLE 'owner' WITH LOGIN 
# #     ENCRYPTED PASSWORD 'secret';
# #
# resource "postgresql_role" "dbowner" {
#   name     = var.postgresql_role__owner__name
#   password = var.postgresql_role__owner__password
#   login    = true
#   replication = true
#   connection_limit = -1
# }

# # Equivalent SQL:
# #
# #     CREATE ROLE 'deployer' WITH LOGIN 
# #     ENCRYPTED PASSWORD 'secret';
# #
# resource "postgresql_role" "deployer" {
#   name     = var.postgresql_role__deployer__name
#   password = var.postgresql_role__deployer__password
#   login    = true
#   replication = true
#   connection_limit = -1
# }

# # Equivalent SQL:
# #
# #     CREATE ROLE 'reader' WITH LOGIN 
# #     ENCRYPTED PASSWORD 'secret';
# #
# resource "postgresql_role" "reader" {
#   name     = var.postgresql_role__reader__name
#   password = var.postgresql_role__reader__password
#   login    = true
#   replication = true
#   connection_limit = -1
# }

# # Equivalent SQL:
# #
# #     CREATE SCHEMA 'public';
# #
# resource "postgresql_schema" "public" {
#   name = "public"
#   owner = "postgres"

#   # The "owner" role can do everything.
#   # This is the role that has full access.
#   policy {
#     create_with_grant = true
#     usage_with_grant  = true
#     role              = "${postgresql_role.owner.name}"
#   }

#   # The "deployer" role can create new objects in the schema
#   # This is the role that runs releases, migrations, etc.
#   policy {
#     create_with_grant = true
#     usage_with_grant  = true
#     role   = "${postgresql_role.deployer.name}"
#   }

#   # The "reader" role can read everything by default.
#   # This is the role that must never has write access.
#   policy {
#     usage = true
#     role  = "${postgresql_role.reader.name}"
#   }

# }

# # Equivalent SQL:
# #
# #     CREATE DATABASE demo;
# #
# resource "postgresql_database" "db" {
#   name              = var.rds_db_name
#   owner             = var.rds_db_owner
#   template          = "template0"
#   encoding          = "UTF8"
#   lc_collate        = "C"
#   lc_ctype          = "C"
#   connection_limit  = 1
#   allow_connections = true
# }

# # Equivalent SQL:
# #
# #     GRANT ALL ON DATABASE 'demo' TO 'owner';
# #
# resource "postgresql_grant" "dbowner" {
#   database    = var.rds_db_name
#   role        = var.rds_db_owner
#   schema      = "public"
#   object_type = "database"
#   privileges  = ["ALL"]
# }

# # Equivalent SQL:
# #
# #     GRANT ALL ON DATABASE 'demo' TO 'deployer';
# #
# resource "postgresql_grant" "deployer" {
#   database    = var.postgresql_database__name
#   role        = var.postgresql_role__deployer__name
#   schema      = "public"
#   object_type = "database"
#   privileges  = ["ALL"]
# }

# # Equivalent SQL:
# #
# #     GRANT SELECT ON ALL TABLES
# #     IN SCHEMA public
# #     TO reader;
# #
# resource "postgresql_grant" "reader" {
#   database    = var.postgresql_database__name
#   role        = var.postgresql_role__reader__name
#   schema      = "public"
#   object_type = "table"
#   privileges  = ["SELECT"]
# }

# # Equivalent SQL:
# #
# #     ALTER DEFAULT PRIVILEGES
# #     IN SCHEMA public
# #     GRANT SELECT ON TABLES TO reader;
# #
# resource "postgresql_default_privileges" "reader" {
#   database = var.postgresql_database__name
#   role     = var.postgresql_role__reader__name
#   schema   = "public"
#   owner       = var.postgresql_role__reader__name
#   object_type = "table"
#   privileges  = ["SELECT"]
# }
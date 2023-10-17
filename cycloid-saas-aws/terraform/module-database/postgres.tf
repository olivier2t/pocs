##################
# Variables      #
##################
variable "rds_postgres_instance_class" {
  description = "PostgreSQL instance type."
  default     = "db.t3.micro"
}

variable "rds_postgres_allocated_storage" {
  description = "Disk size for the RDS PostgreSQL instance (Go)"
  default     = 10
}

variable "rds_postgres_max_allocated_storage" {
  description = "PostgreSQL RDS max disk size (Go). 0 disables Storage Autoscaling."
  default     = 100
}

variable "rds_postgres_storage_type" {
  description = "RDS PostgreSQL Storage Type"
  default     = "gp3"
}

variable "rds_postgres_engine" {
  description = "DB PostgreSQL engine. Engine values include aurora, aurora-mysql, aurora-postgresql, docdb, mariadb, mysql, neptune, oracle-ee, oracle-se, oracle-se1, oracle-se2, postgres, sqlserver-ee, sqlserver-ex, sqlserver-se, and sqlserver-web."
  default     = "postgres"
}

variable "rds_postgres_engine_version" {
  description = "DB PostgreSQL engine version."
  default     = "14.5"
}

variable "rds_postgres_family" {
  description = "RDS PostgreSQL engine family."
  default     = "postgres14"
}

variable "rds_postgres_database" {
  description = "PostgreSQL Database name to create."
  default     = "cycloid"
}

variable "rds_postgres_username" {
  description = "PostgreSQL Username to connect to the RDS instance"
  default     = "cycloid"
}

variable "rds_postgres_multiaz" {
  description = "Whether to enable RDS PostgreSQL Multi-AZ mode or not."
  default     = true
}

variable "rds_postgres_maintenance_window" {
  default = "tue:06:00-tue:07:00"
}

variable "rds_postgres_backup_window" {
  default = "02:00-04:00"
}

variable "rds_postgres_backup_retention" {
  default = 15
}

variable "rds_postgres_skip_final_snapshot" {
  default = true
}

##################
# Security Group #
##################

resource "aws_security_group" "cycloid-postgres" {
  name        = "${var.customer}-${var.project}-${var.env}-postgres"
  description = "PostgreSQL RDS ${var.env} for ${var.project}"
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, {
    Name   = "${var.customer}-${var.project}-${var.env}-postgres"
    engine = "postgres"
    role   = "rds"
  })
}

resource "aws_security_group_rule" "egress-postgres-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cycloid-postgres.id
}

resource "aws_security_group_rule" "ingress-postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.cycloid_sg_id
  security_group_id        = aws_security_group.cycloid-postgres.id
}

###################
# Parameter Group #
###################

resource "aws_db_parameter_group" "cycloid-postgres" {
  name   = "${var.project}-${var.env}-${var.rds_postgres_family}"
  family = var.rds_postgres_family

  parameter {
    name  = "autovacuum"
    value = 1
  }

  parameter {
    name  = "client_encoding"
    value = "utf8"
  }
}

##################
# Password       #
##################

resource "random_password" "rds_postgres_password" {
  length           = 32
  special          = true
  override_special = "!#$%*-_"
}

##################
# Database       #
##################

resource "aws_db_instance" "cycloid-postgres" {
  identifier        = "${var.customer}-${var.project}-${var.env}-postgres"
  allocated_storage = var.rds_postgres_allocated_storage
  storage_type      = var.rds_postgres_storage_type
  engine            = var.rds_postgres_engine
  engine_version    = var.rds_postgres_engine_version
  instance_class    = var.rds_postgres_instance_class
  db_name           = var.rds_postgres_database
  username          = var.rds_postgres_username
  password          = random_password.rds_postgres_password.result

  multi_az                  = var.rds_postgres_multiaz
  db_subnet_group_name      = var.database_subnet_group_name
  parameter_group_name      = aws_db_parameter_group.cycloid-postgres.id
  apply_immediately         = true
  maintenance_window        = var.rds_postgres_maintenance_window
  backup_window             = var.rds_postgres_backup_window
  backup_retention_period   = var.rds_postgres_backup_retention
  copy_tags_to_snapshot     = true
  final_snapshot_identifier = "${var.customer}-${var.project}-${var.env}-postgres"
  skip_final_snapshot       = var.rds_postgres_skip_final_snapshot

  vpc_security_group_ids = [aws_security_group.cycloid-postgres.id]
  publicly_accessible    = false

  tags = merge(local.merged_tags, {
    Name   = "${var.customer}-${var.project}-${var.env}-postgres"
    engine = "postgres"
    role   = "rds"
  })
}

###########
# Outputs #
###########

output "rds_postgres_address" {
  value = try(aws_db_instance.cycloid-postgres.address, "")
}

output "rds_postgres_port" {
  value = try(aws_db_instance.cycloid-postgres.port, "")
}

output "rds_postgres_database" {
  value = try(aws_db_instance.cycloid-postgres.db_name, "")
}

output "rds_postgres_username" {
  value = try(aws_db_instance.cycloid-postgres.username, "")
}

output "rds_postgres_password" {
  value     = try(random_password.rds_postgres_password.result, "")
  sensitive = true
}

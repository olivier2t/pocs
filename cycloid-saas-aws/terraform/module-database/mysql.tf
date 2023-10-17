##################
# Variables      #
##################
variable "rds_mysql_instance_class" {
  description = "MySQL instance type."
  default     = "db.t3.micro"
}

variable "rds_mysql_allocated_storage" {
  description = "Disk size for the RDS MySQL instance (Go)"
  default     = 10
}

variable "rds_mysql_max_allocated_storage" {
  description = "MySQL RDS max disk size (Go). 0 disables Storage Autoscaling."
  default     = 100
}

variable "rds_mysql_storage_type" {
  description = "RDS MySQL Storage Type"
  default     = "gp3"
}

variable "rds_mysql_engine" {
  description = "DB MySQL engine. Engine values include aurora, aurora-mysql, aurora-postgresql, docdb, mariadb, mysql, neptune, oracle-ee, oracle-se, oracle-se1, oracle-se2, postgres, sqlserver-ee, sqlserver-ex, sqlserver-se, and sqlserver-web."
  default     = "mysql"
}

variable "rds_mysql_engine_version" {
  description = "DB MySQL engine version."
  default     = "8.0"
}

variable "rds_mysql_family" {
  description = "RDS MySQL engine family."
  default     = "mysql8.0"
}

variable "rds_mysql_database" {
  description = "MySQL Database name to create."
  default     = "cycloid"
}

variable "rds_mysql_username" {
  description = "MySQL Username to connect to the RDS instance"
  default     = "cycloid"
}

variable "rds_mysql_multiaz" {
  description = "Whether to enable RDS MySQL Multi-AZ mode or not."
  default     = true
}

variable "rds_mysql_maintenance_window" {
  default = "tue:06:00-tue:07:00"
}

variable "rds_mysql_backup_window" {
  default = "02:00-04:00"
}

variable "rds_mysql_backup_retention" {
  default = 15
}

variable "rds_mysql_skip_final_snapshot" {
  default = true
}


##################
# Security Group #
##################

resource "aws_security_group" "cycloid-mysql" {
  name        = "${var.customer}-${var.project}-${var.env}-mysql"
  description = "MySQL RDS ${var.env} for ${var.project}"
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, {
    Name   = "${var.customer}-${var.project}-${var.env}-mysql"
    engine = "mysql"
    role   = "rds"
  })
}

resource "aws_security_group_rule" "egress-mysql-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cycloid-mysql.id
}

resource "aws_security_group_rule" "ingress-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.cycloid_sg_id
  security_group_id        = aws_security_group.cycloid-mysql.id
}


###################
# Parameter Group #
###################

resource "aws_db_parameter_group" "cycloid-mysql" {
  name   = "${var.project}-${var.env}-${var.rds_mysql_family}"
  family = var.rds_mysql_family

  parameter {
    name         = "sql_mode"
    value        = "NO_ENGINE_SUBSTITUTION"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }

  parameter {
    name         = "innodb_buffer_pool_size"
    value        = "{DBInstanceClassMemory*2/3}"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_allowed_packet"
    value        = "33554432"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "wait_timeout"
    value        = "7200"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "tmp_table_size"
    value        = "134217728"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_heap_table_size"
    value        = "134217728"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "log_output"
    value = "file"
  }
}

##################
# Password       #
##################

resource "random_password" "rds_mysql_password" {
  length           = 32
  special          = true
  override_special = "!#$%*-_"
}

##################
# Database       #
##################

resource "aws_db_instance" "cycloid-mysql" {
  identifier        = "${var.customer}-${var.project}-${var.env}-mysql"
  allocated_storage = var.rds_mysql_allocated_storage
  storage_type      = var.rds_mysql_storage_type
  engine            = var.rds_mysql_engine
  engine_version    = var.rds_mysql_engine_version
  instance_class    = var.rds_mysql_instance_class
  db_name           = var.rds_mysql_database
  username          = var.rds_mysql_username
  password          = random_password.rds_mysql_password.result

  multi_az                  = var.rds_mysql_multiaz
  db_subnet_group_name      = var.database_subnet_group_name
  parameter_group_name      = aws_db_parameter_group.cycloid-mysql.id
  apply_immediately         = true
  maintenance_window        = var.rds_mysql_maintenance_window
  backup_window             = var.rds_mysql_backup_window
  backup_retention_period   = var.rds_mysql_backup_retention
  copy_tags_to_snapshot     = true
  final_snapshot_identifier = "${var.customer}-${var.project}-${var.env}-mysql"
  skip_final_snapshot       = var.rds_mysql_skip_final_snapshot

  vpc_security_group_ids = [aws_security_group.cycloid-mysql.id]
  publicly_accessible    = false

  tags = merge(local.merged_tags, {
    Name   = "${var.customer}-${var.project}-${var.env}-mysql"
    engine = "mysql"
    role   = "rds"
  })
}



###########
# Outputs #
###########

output "rds_mysql_address" {
  value = try(aws_db_instance.cycloid-mysql.address, "")
}

output "rds_mysql_port" {
  value = try(aws_db_instance.cycloid-mysql.port, "")
}

output "rds_mysql_database" {
  value = try(aws_db_instance.cycloid-mysql.db_name, "")
}

output "rds_mysql_username" {
  value = try(aws_db_instance.cycloid-mysql.username, "")
}

output "rds_mysql_password" {
  value     = try(random_password.rds_mysql_password.result, "")
  sensitive = true
}

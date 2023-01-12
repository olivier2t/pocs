resource "random_password" "password" {
  length = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "rds" {
  identifier             = "${var.customer}-${var.project}-${var.env}-rds"
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  engine                 = var.rds_engine
  username               = var.rds_username
  password               = random_password.password.result
  db_subnet_group_name   = aws_db_subnet_group.subnetgroup.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

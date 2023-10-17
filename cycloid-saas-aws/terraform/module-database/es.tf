##################
# Variables      #
##################

variable "es_instance_type" {
  description = "The instance type for the ElasticSearch server"
  default     = "t3a.large"
}

variable "es_disk_size" {
  description = "The EBS disk size for the ElasticSearch data"
  default     = 30
}

variable "es_volume_type" {
  description = "The EBS volume type for the ElasticSearch data"
  default     = "gp3"
}

variable "es_os_user" {
  description = "Admin username to connect to ElasticSearch instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

##################
# Instance       #
##################

variable "es_keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}

resource "aws_key_pair" "cycloid" {
  key_name   = "${var.customer}-${var.project}-${var.env}-cycloid-es"
  public_key = var.es_keypair_public
}

resource "aws_instance" "cycloid-es" {
  ami           = data.aws_ami.bitnami-es.id
  instance_type = var.es_instance_type
  key_name      = aws_key_pair.cycloid.key_name

  vpc_security_group_ids = [aws_security_group.cycloid-es.id]

  subnet_id                   = var.subnet_ids[0]
  disable_api_termination     = false
  associate_public_ip_address = false

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-es"
    role = "es"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}

##################
# Volume         #
##################

data "aws_subnet" "cycloid-es" {
  id = var.subnet_ids[0]
}

resource "aws_ebs_volume" "cycloid-es" {
  availability_zone = data.aws_subnet.cycloid-es.availability_zone
  size              = var.es_disk_size
  type              = var.es_volume_type

  tags = {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-es"
    role = "es"
  }
}

resource "aws_volume_attachment" "cycloid-es" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.cycloid-es.id
  instance_id = aws_instance.cycloid-es.id
}

##################
# Security Group #
##################

resource "aws_security_group" "cycloid-es" {
  name        = "${var.customer}-${var.project}-${var.env}-es"
  description = "ElasticSearch ${var.env} for ${var.project}"
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-es"
    role = "es"
  })
}

resource "aws_security_group_rule" "egress-es-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cycloid-es.id
}

resource "aws_security_group_rule" "ingress-es" {
  type                     = "ingress"
  from_port                = 9200
  to_port                  = 9200
  protocol                 = "tcp"
  source_security_group_id = var.cycloid_sg_id
  security_group_id        = aws_security_group.cycloid-es.id
}

###########
# Outputs #
###########

output "es_private_dns" {
  description = "The private DNS name of the ES EC2 server"
  value       = aws_instance.cycloid-es.private_dns
}

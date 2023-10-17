resource "aws_instance" "cycloid-core" {
  count = var.core_instance_count

  ami           = data.aws_ami.debian.id
  instance_type = var.core_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.cycloid-core.id]

  subnet_id                   = element(var.subnet_ids, count.index)
  disable_api_termination     = false
  associate_public_ip_address = false

  root_block_device {
    volume_size = var.core_volume_size
    volume_type = var.core_volume_type
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-core"
    role = "cycloid-core"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}

##################
# Security Group #
##################

resource "aws_security_group" "cycloid-core" {
  name        = "${var.customer}-${var.project}-${var.env}-cycloid-core"
  description = "Cycloid core ${var.env} for ${var.project}"
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cycloid-core"
    role = "cycloid-core"
  })
}

resource "aws_security_group_rule" "egress-core-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cycloid-core.id
}

resource "aws_security_group_rule" "ingress-core-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.trusted_cidr_blocks
  security_group_id = aws_security_group.cycloid-core.id
}

resource "aws_security_group_rule" "ingress-core-mailhog" {
  type              = "ingress"
  from_port         = 8025
  to_port           = 8025
  protocol          = "tcp"
  cidr_blocks       = var.trusted_cidr_blocks
  security_group_id = aws_security_group.cycloid-core.id
}

resource "aws_security_group_rule" "ingress-core-asynqmon" {
  type              = "ingress"
  from_port         = 5678
  to_port           = 5678
  protocol          = "tcp"
  cidr_blocks       = var.trusted_cidr_blocks
  security_group_id = aws_security_group.cycloid-core.id
}

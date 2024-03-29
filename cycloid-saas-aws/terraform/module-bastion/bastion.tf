resource "aws_security_group" "bastion" {
  count = var.bastion ? 1 : 0

  name        = "${var.customer}-${var.project}-${var.env}-bastion"
  description = "Allow accessing the bastion via SSH from the internet."
  vpc_id      = data.aws_subnet.selected.vpc_id

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-bastion"
  })
}

resource "aws_security_group_rule" "egress-all" {
  count = var.bastion ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion[0].id
}

resource "aws_security_group_rule" "ingress-ssh" {
  count = var.bastion ? 1 : 0

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion[0].id
}

resource "aws_instance" "bastion" {
  count = var.bastion ? 1 : 0

  ami           = data.aws_ami.debian.id
  instance_type = var.bastion_instance_type
  key_name      = aws_key_pair.infra[0].key_name

  vpc_security_group_ids = [aws_security_group.bastion[0].id]

  subnet_id                   = var.subnet_id
  disable_api_termination     = false
  associate_public_ip_address = true

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-bastion"
    role = "bastion"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}

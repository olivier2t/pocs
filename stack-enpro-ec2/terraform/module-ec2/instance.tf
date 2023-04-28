resource "aws_security_group" "ec2" {
  name        = "${var.tag_name}"
  description = "Allow accessing the instance from the internet."
  vpc_id      = var.aws_vpc

  tags = merge(local.merged_tags, {
    role       = "security_group"
  })
}

resource "aws_security_group_rule" "egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_instance" "ec2" {
  ami           = var.vm_instance_ami
  instance_type = var.vm_instance_type
  key_name      = var.aws_key

  vpc_security_group_ids = [aws_security_group.ec2.id]

  subnet_id               = var.aws_subnet
  disable_api_termination = false

  root_block_device {
    volume_size           = var.vm_disk_size
    delete_on_termination = true
  }

  user_data_base64 = base64encode(file("${path.module}/userdata.sh.tpl"))

  tags = merge(local.merged_tags, {
    role = "ec2"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
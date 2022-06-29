resource "aws_security_group" "cloud-init" {
  name        = "${var.customer}-${var.project}-${var.env}-cloud-init"
  description = "Allow accessing the instance from the internet."
  vpc_id      = module.vpc.vpc_id

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-cloud-init"
  })
}

resource "aws_security_group_rule" "egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloud-init.id
}

resource "aws_security_group_rule" "ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloud-init.id
}

resource "aws_security_group_rule" "ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloud-init.id
}

resource "aws_security_group_rule" "ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloud-init.id
}

resource "aws_security_group_rule" "ingress-teleport" {
  type              = "ingress"
  from_port         = var.targetport
  to_port           = var.targetport
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloud-init.id
}


resource "aws_instance" "cloud-init" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.vm_instance_type
  key_name      = aws_key_pair.cloud-init.key_name

  vpc_security_group_ids = [aws_security_group.cloud-init.id]

  subnet_id               = module.vpc.public_subnets[0]
  disable_api_termination = false
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.vm_disk_size
    delete_on_termination = true
  }

  user_data_base64 = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      app_service_name = var.app_service_name
      token = var.token
      target = var.target
      targetport = var.targetport
      teleportserver = var.teleportserver
      teleportport = var.teleportport
      organisation = var.customer
      project = var.project
      env = var.env
    }
  ))

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-cloud-init"
    role = "cloud-init"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
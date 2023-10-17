############
#  SG      #
############

resource "aws_security_group" "nlb" {
  name        = "${var.project}-${var.env}-cc"
  description = "Used by Concourse ${var.project}-${var.env}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.core_concourse_port
    to_port     = var.core_concourse_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "nlb-to-core-concourse" {
  type                     = "ingress"
  from_port                = var.core_concourse_port
  to_port                  = var.core_concourse_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb.id
  security_group_id        = aws_security_group.cycloid-core.id
}

############
#  NLB     #
############

resource "aws_lb" "cycloid-concourse" {
  name               = "${var.project}-${var.env}-cc"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_ids


  tags = {
    role = "nlb"
  }
}

resource "aws_lb_listener" "cycloid-concourse" {
  load_balancer_arn = aws_lb.cycloid-concourse.arn
  port              = var.core_concourse_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cycloid-concourse.arn
  }
}

resource "aws_lb_target_group" "cycloid-concourse" {
  name        = "${var.project}-${var.env}-cc"
  port        = var.core_concourse_port
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  stickiness {
    type    = "source_ip"
    enabled = true
  }
}

##############
# Attachment #
##############
resource "aws_lb_target_group_attachment" "cycloid-concourse" {
  count            = var.core_instance_count
  target_group_arn = aws_lb_target_group.cycloid-concourse.arn
  target_id        = aws_instance.cycloid-core[count.index].id
  port             = var.core_concourse_port
}

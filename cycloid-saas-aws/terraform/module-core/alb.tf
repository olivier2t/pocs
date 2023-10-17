data "aws_acm_certificate" "cycloid-core" {
  domain   = var.core_hosted_zone
  statuses = ["ISSUED"]
}

############
#  SG      #
############

resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.env}-core"
  description = "Used by cycloid ${var.project}-${var.env}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "lb-to-core-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.cycloid-core.id
}

resource "aws_security_group_rule" "lb-to-core-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.cycloid-core.id
}

############
#  LB      #
############

resource "aws_lb" "cycloid" {
  name               = "${var.project}-${var.env}-core"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids

  tags = {
    role = "alb"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.cycloid.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.cycloid-core.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cycloid.arn
  }
}

resource "aws_lb_target_group" "cycloid" {
  name        = "${var.project}-${var.env}-core-https"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  stickiness {
    type    = "source_ip"
    enabled = true
  }

  health_check {
    path = "/status"
  }
}

# resource "aws_lb_target_group" "cycloid-http" {
#   name        = "${var.project}-${var.env}-cycloid-http"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "ip"
#   vpc_id      = var.vpc_id
#
#   stickiness {
#     enabled = true
#     type    = "source_ip"
#   }
#
#   health_check {
#     path = "/status"
#   }
# }

##############
# Attachment #
##############
resource "aws_lb_target_group_attachment" "cycloid" {
  count            = var.core_instance_count
  target_group_arn = aws_lb_target_group.cycloid.arn
  target_id        = aws_instance.cycloid-core[count.index].id
  port             = 443
}

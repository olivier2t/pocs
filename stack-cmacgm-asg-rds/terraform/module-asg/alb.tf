data "aws_acm_certificate" "issued" {
  domain   = "*.shared-services-noprd.aws.cld.cma-cgm.com"
  statuses = ["ISSUED"]
}

resource "aws_lb" "alb" {
  # "name" cannot be longer than 32 characters
  name               = "${var.project}-${var.env}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.vpc_private_subnets

  tags = merge(local.merged_tags, {
    Name        = "${var.customer}-${var.project}-${var.env}-alb"
    Environment = var.env
    role        = "alb"
  })
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb.arn
    type             = "redirect"

    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_ssl" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    target_group_arn = aws_lb_target_group.alb.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "alb" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    matcher = "200,302"
    healthy_threshold = 5
    unhealthy_threshold = 3
  }
}

resource "aws_autoscaling_attachment" "front" {
  autoscaling_group_name = aws_autoscaling_group.front.id
  lb_target_group_arn   = aws_lb_target_group.alb.arn
}


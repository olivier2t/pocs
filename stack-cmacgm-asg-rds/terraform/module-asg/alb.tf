resource "aws_lb" "alb" {
  name               = "${var.customer}-${var.project}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.vpc_public_subnets

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
    target_group_arn = aws_lb_target_group.asg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "alb" {
  name     = "${var.customer}-${var.project}-${var.env}-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "front" {
  autoscaling_group_name = aws_autoscaling_group.front.id
  alb_target_group_arn   = aws_lb_target_group.alb.arn
}
# Security Group for ALB
resource "aws_security_group" "atlassian-alb" {
    name = "${var.name}-load-balancer"
    description = "allow HTTPS to ${var.name} Load Balancer (ALB)"
    vpc_id = "${module.vpc.vpc_id}"
    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "${var.name}"
    }
}
# Create a single load balancer for all Atlassian services
resource "aws_alb" "atlassian" {
  name            = "${var.name}"
  internal        = false
  idle_timeout    = "300"
  security_groups = [
    "${aws_security_group.atlassian-alb.id}",
    "${module.open-egress-sg.id}"
  ]
  subnets = ["${module.vpc.public_subnet_ids}"]
  enable_deletion_protection = true

# access_logs {
#   bucket = "${aws_s3_bucket.alb_logs.bucket}"
#   prefix = "test-alb"
# }

  tags {
    Name = "${var.name}"
  }
}

# Define a listener
resource "aws_alb_listener" "atlassian" {
  load_balancer_arn = "${aws_alb.atlassian.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.ssl_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.bitbucket.arn}"
    type             = "forward"
  }
}


# Connect bitbucket ASG up to the Application Load Balancer (see load-balancer.tf)
resource "aws_alb_target_group" "bitbucket" {
  name     = "${var.name}-bitbucket"
  port     = 7990
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb_listener_rule" "bitbucket" {
  listener_arn = "${aws_alb_listener.atlassian.arn}"
  priority     = 99

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.bitbucket.arn}"
  }

  condition {
    field  = "host-header"
    values = ["bitbucket.example.com"]
  }
}

# create single-node auto-scaling group to run bitbucket
module "bitbucket-asg" {
  ...
  alb_target_group_arns = ["${aws_alb_target_group.bitbucket.arn}"]
}
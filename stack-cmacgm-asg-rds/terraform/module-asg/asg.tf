resource "aws_iam_instance_profile" "ec2" {
  name = "${var.customer}-${var.project}-${var.env}-wp-ip"
  role = aws_iam_role.ec2.name
}

data "aws_iam_policy" "amazon_ec2_role_for_ssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "${var.customer}-${var.project}-${var.env}-wp-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
  managed_policy_arns = [
    data.aws_iam_policy.amazon_ec2_role_for_ssm.arn
  ]
}

resource "aws_launch_template" "front" {
  name_prefix = "${var.customer}-${var.project}-${var.env}-"

  ebs_optimized = true

  block_device_mappings {
    device_name = "/dev/xvdb"

    ebs {
      volume_size           = 20
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }

  image_id      = "ami-082a12a990b3012f3"
  instance_type = var.asg_instance_type

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.front.id]

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      tomap({
        "Name" = "demo-cycloid"
      })
    )
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  update_default_version = true

  user_data = base64encode(templatefile("${path.module}/user-data.sh.tpl", {
    RDS_USERNAME                                         = var.rds_username
    RDS_PASSWORD                     = var.rds_password
    RDS_DB_NAME                  = "db01"
    RDS_ENDPOINT                = var.rds_endpoint
  }))

}

resource "aws_autoscaling_group" "front" {
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  health_check_type = "EC2"
  launch_template {
    id      = aws_launch_template.front.id
    version = aws_launch_template.front.latest_version
  }
  target_group_arns = [aws_lb_target_group.alb.arn]
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
  vpc_zone_identifier  = var.vpc_private_subnets

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupMinSize",
    "GroupMaxSize",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  depends_on = [
    aws_launch_template.front,
    aws_lb_target_group.alb
  ]
}
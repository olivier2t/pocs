resource "aws_launch_configuration" "front" {
  name_prefix     = "${var.customer}-${var.project}-${var.env}-"
  image_id        = var.asg_ami_id
  instance_type   = var.asg_instance_type
#   user_data       = file("user-data.sh")
  security_groups = [aws_security_group.front.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "front" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.front.name
  vpc_zone_identifier  = var.vpc_private_subnets
}

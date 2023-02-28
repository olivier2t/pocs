
module "asg" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-asg"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #######
  # VPC #
  #######

  #. vpc_id: []
  #+ The ID for the VPC
  vpc_id = data.aws_vpc.selected.id

  #. vpc_azs: []
  #+ The Availability zones of the VPC
  vpc_azs = data.aws_availability_zones.available.all_availability_zones

  #. vpc_private_subnets: []
  #+ The private subnets list of the VPC
  vpc_private_subnets = [data.aws_subnet.selected_private_1a.id, data.aws_subnet.selected_private_1b.id, data.aws_subnet.selected_private_1c.id]

  #. vpc_public_subnets: []
  #+ The public subnets list of the VPC
  # vpc_public_subnets = module.vpc.vpc_public_subnets

  #######
  # ASG #
  #######

  #. asg_ami_id: ami-089f338f3a2e69431
  #+ AMI ID for the ASG
  asg_ami_id = "ami-089f338f3a2e69431"

  #. asg_instance_type: "t3a.small"
  #+ Instance types to use in the ASG
  asg_instance_type = "t3a.small"

  #. asg_min_size: 1
  #+ Minimum size for the ALB
  asg_min_size = 1

  #. asg_max_size: 2
  #+ Maximum size for the ALB
  asg_max_size = 2

  #. asg_desired_capacity: 1
  #+ Desired capacity for the ALB
  asg_desired_capacity = 1

  #######
  # RDS #
  #######

  #. rds_username: rds_user
  #+ The database master username
  rds_endpoint = module.rds.rds_endpoint
  rds_username = module.rds.rds_username
  rds_password = module.rds.rds_password

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }
}


module "rds" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-rds"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }

  #######
  # VPC #
  #######

  #. vpc_id: []
  #+ The ID for the VPC
  vpc_id = data.aws_vpc.selected.id

  #. vpc_azs: []
  #+ The Availability zones of the VPC
  vpc_azs = data.aws_availability_zones.available.names

  #. vpc_private_subnets: []
  #+ The private subnets list of the VPC
  vpc_private_subnets = [data.aws_subnet.selected_private_1a.id, data.aws_subnet.selected_private_1b.id, data.aws_subnet.selected_private_1c.id]

  #. vpc_public_subnets: []
  #+ The public subnets list of the VPC
  # vpc_public_subnets = module.vpc.vpc_public_subnets

  #######
  # ASG #
  #######

  #. rds_allocated_storage: 32
  #+ Disk size for the RDS cluster (Go)
  rds_allocated_storage = 32

  #. rds_instance_class: db.t3.medium
  #+ Instance class for the RDS cluster
  rds_instance_class = "db.t3.medium"
}
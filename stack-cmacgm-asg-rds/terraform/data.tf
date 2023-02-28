data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }

  filter {
    name   = "tag:Name"
    values = ["observability*"]
  }
}

data "aws_subnet" "selected_private_1a" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }

  filter {
    name   = "tag:Name"
    values = ["observability*-private-1"]
  }
}

data "aws_subnet" "selected_private_1b" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }

  filter {
    name   = "tag:Name"
    values = ["observability*-private-2"]
  }
}

data "aws_subnet" "selected_private_1c" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Terraform"
    values = ["true"]
  }

  filter {
    name   = "tag:Name"
    values = ["observability*-private-3"]
  }
}

data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

/*
data "aws_route53_zone" "private" {
  provider     = aws.network
  name         = "shared-services-noprd.aws.cld.cma-cgm.com."
  private_zone = true
}
*/
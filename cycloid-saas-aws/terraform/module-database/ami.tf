data "aws_ami" "bitnami-es" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-elasticsearch-7.17.*-linux-debian-11-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Bitnami
}

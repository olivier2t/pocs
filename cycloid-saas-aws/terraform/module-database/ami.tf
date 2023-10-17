data "aws_ami" "bitnami-es" {
  most_recent = true
  name_regex  = "^bitnami-elasticsearch-7\.17.*debian.*"

  filter {
    name   = "name"
    values = ["bitnami-elasticsearch-7.17*"]
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

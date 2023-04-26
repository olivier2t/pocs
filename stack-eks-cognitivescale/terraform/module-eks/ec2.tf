module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.1"
  ami = "ami-01de8ddb33de7a3d3"
  subnet_id = aws_subnet.public-us-east-1a.id
  instance_type = "t3.small"
  key_name = "kaiser-certifai"
  # user_data = file("userdata.sh")
  user_data_base64 = base64encode(file("${path.module}/userdata.sh"))
  vpc_security_group_ids = [aws_security_group.sg.id]
  root_block_device = [{
    volume_size = 500
    volume_type = "gp3"
  }]
  tags = {
        Name = "bastion-certifai-125-eks-dev"
    }
}

output "private_ec2_ip" {
  value       = module.ec2-instance.private_ip
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.main.id
    name = "BastionSG"
    ingress {
        from_port = 22
        protocol = "TCP"
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_eip" "lb" {
  instance = module.ec2-instance.id
  vpc      = true
}

output "public_ec2_ip" {
  value       = aws_eip.lb.public_ip
}

# # resource "aws_ebs_volume" "this" {
# # availability_zone = "us-east-1a"
# #   size              = 500
# #   encrypted         = true
# #   type              = "gp2"
# # tags = {
# #     Name = "bastion-ebs-volume"
# #     }
# # }

# # resource "aws_volume_attachment" "ebs_att" {
# #   device_name = "/dev/xvdh"
# #   volume_id   = aws_ebs_volume.this.id
# #   instance_id = module.ec2-instance.id
# # }

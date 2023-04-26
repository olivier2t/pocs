resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "certifai-125-eks-dev-igw"
  }
}

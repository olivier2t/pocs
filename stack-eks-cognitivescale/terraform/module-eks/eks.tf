resource "aws_iam_role" "eks-cluster" {
  name = "eks-cluster-${var.cluster_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    # endpoint_private_access = true
    # endpoint_public_access  = false
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.amazon-eks-cluster-policy]
}

output "cluster_security_group_id" {
    value   = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

# SG created by EKS
# data "aws_security_group" "imported_sg" {
#   id = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
#     }
    
#     # SG Rule which you would like to add
#     resource "aws_security_group_rule" "example" {
#       type              = "ingress"
#       # from_port         = 0
#       # to_port           = 65535
#       from_port         = 443
#       to_port           = 443
#       protocol          = "tcp"
#       #cidr_blocks       = ["${module.ec2-instance.private_ip}/32"]
    
#       security_group_id = data.aws_security_group.imported_sg.id
#     }

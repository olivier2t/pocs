# resource "aws_ecr_repository" "foo" {
#   name                 = "certifai-125-eks-dev-repository"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }
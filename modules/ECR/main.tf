resource "aws_ecr_repository" "my_ecr_repository" {
  name                 = var.ecr_name
  image_tag_mutability = var.ecr_image_tag_mutability

  tags = var.ecr_tags

}

resource "aws_ecr_repository_policy" "ecr_policy_attachment" {
  repository = aws_ecr_repository.my_ecr_repository.name
  policy     = var.ecr_repository_policy # pass in the policy as a string
}
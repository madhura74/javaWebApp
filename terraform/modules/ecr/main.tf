

resource "aws_ecr_repository" "ecr" {
  name                 = "madecr01"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
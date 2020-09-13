resource "aws_ecr_repository" "python_app" {
  name                 = "pythonapp"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

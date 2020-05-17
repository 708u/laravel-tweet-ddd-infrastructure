resource "aws_ecr_repository" "app" {
  name = "${var.project}-app"
}

resource "aws_ecr_repository" "nginx" {
  name = "${var.project}-nginx"
}

resource "aws_ecr_lifecycle_policy" "app_policy" {
  repository = aws_ecr_repository.app.name
  policy     = file("./policies/ecr/lifecycle.json")
}

resource "aws_ecr_lifecycle_policy" "nginx_policy" {
  repository = aws_ecr_repository.nginx.name
  policy     = file("./policies/ecr/lifecycle.json")
}

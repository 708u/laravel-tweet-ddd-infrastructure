resource "aws_ecr_repository" "app" {
  name = "${var.project}-app"
}

resource "aws_ecr_repository" "nginx" {
  name = "${var.project}-nginx"
}

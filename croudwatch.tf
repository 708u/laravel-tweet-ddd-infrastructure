resource "aws_cloudwatch_log_group" "service-app" {
  name = "${var.project}-app"
}
resource "aws_cloudwatch_log_group" "service-nginx" {
  name = "${var.project}-nginx"
}

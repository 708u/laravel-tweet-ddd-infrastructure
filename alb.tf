resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "${var.project}-alb"

  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id]
}

resource "aws_lb_listener" "https" {
  port     = 443
  protocol = "HTTPS"

  certificate_arn   = aws_acm_certificate.main.arn
  load_balancer_arn = aws_lb.main.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }

  depends_on = [aws_acm_certificate.main]
}

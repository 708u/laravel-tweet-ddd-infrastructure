resource "aws_lb" "main" {
  name               = "${var.project}-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id]
}

resource "aws_lb_target_group" "web" {
  name        = "${var.project}-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    interval            = 30
    path                = "/healthcheck"
    port                = 80
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "https" {
  port     = 443
  protocol = "HTTPS"

  certificate_arn   = aws_acm_certificate.main.arn
  load_balancer_arn = aws_lb.main.arn

  default_action {
    target_group_arn = aws_lb_target_group.web.arn
    type             = "forward"
  }

  depends_on = [aws_acm_certificate.main]
}

resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "${var.project}-alb"

  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id]
}

resource "aws_security_group" "alb" {
  name        = "${var.project}-alb"
  description = "${var.project}-alb"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = {
    Name = "${var.project}-alb"
  }
}

resource "aws_security_group_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = [var.default_route]
}

resource "aws_security_group_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  cidr_blocks = [var.default_route]
}

# resource "aws_lb_listener" "https" {
#   port     = 443
#   protocol = "HTTPS"

#   certificate_arn = aws_acm_certificate.main.arn
#   load_balancer_arn = aws_lb.main.arn

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/plain"
#       status_code  = "200"
#       message_body = "ok"
#     }
#   }
# }

resource "aws_lb_listener" "http" {
  port     = 80
  protocol = "HTTP"

  load_balancer_arn = aws_lb.main.id

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

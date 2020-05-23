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

resource "aws_security_group" "web" {
  name   = "${var.project}-web"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = {
    Name = "${var.project}-web"
  }
}

resource "aws_security_group" "private_db" {
  name        = "${var.project}-db"
  description = "${var.project}-db"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}

resource "aws_security_group" "private_elasticache" {
  name        = "${var.project}-elasticache"
  description = "${var.project}-elasticache"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}

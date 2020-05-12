resource "aws_security_group" "private_elasticache" {
  name        = "${var.project}-elasticache"
  description = "${var.project}-elasticache"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = "${var.project}-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  engine_version       = "5.0.6"
  port                 = 6379
  parameter_group_name = "default.redis5.0"
  subnet_group_name    = aws_elasticache_subnet_group.main.name
}

resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.project}-cache-subnet"
  description = "${var.project}-cache-subnet"
  subnet_ids  = [aws_subnet.private_elasticache_1a.id, aws_subnet.private_elasticache_1c.id]
}

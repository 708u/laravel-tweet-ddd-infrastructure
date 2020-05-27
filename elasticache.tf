resource "aws_elasticache_cluster" "main" {
  cluster_id           = "${var.project}-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  engine_version       = "5.0.6"
  port                 = 6379
  parameter_group_name = "default.redis5.0"
  subnet_group_name    = aws_elasticache_subnet_group.main.name
  security_group_ids = [
    aws_security_group.private_elasticache.id
  ]
}

resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.project}-cache-subnet"
  description = "${var.project}-cache-subnet"
  subnet_ids  = [aws_subnet.private_elasticache_1a.id, aws_subnet.private_elasticache_1c.id]
}

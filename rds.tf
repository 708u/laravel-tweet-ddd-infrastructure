resource "aws_db_subnet_group" "private_db" {
  name       = "${var.project}-db-group"
  subnet_ids = [aws_subnet.private_db_1a.id, aws_subnet.private_db_1c.id]
  tags = {
    Name = "${var.project}-db-group"
  }
}

resource "aws_db_instance" "db" {
  identifier             = "${var.project}-db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  name                   = replace(var.project, "-", "_")
  username               = replace(var.project, "-", "_")
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.private_db.id]
  db_subnet_group_name   = aws_db_subnet_group.private_db.name
  skip_final_snapshot    = true
}

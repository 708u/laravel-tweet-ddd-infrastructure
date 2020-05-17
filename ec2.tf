resource "aws_instance" "main" {
  ami                         = "ami-0e37e42dff65024ae"
  instance_type               = "t2.small"
  monitoring                  = true
  subnet_id                   = aws_subnet.public_subnet_1a.id
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_profile.name
  user_data                   = file("./user_data.sh")
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web.id]
  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
  }

  tags = {
      Name = "${var.project}-app"
  }
}

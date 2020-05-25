resource "aws_instance" "main" {
  ami                         = "ami-03179588b2f59f257"
  instance_type               = "t2.micro"
  monitoring                  = true
  subnet_id                   = aws_subnet.public_subnet_1a.id
  iam_instance_profile        = aws_iam_instance_profile.ecs_profile.name
  user_data                   = file("./user_data.sh")
  associate_public_ip_address = true
  key_name                    = aws_key_pair.instance_ssh.id
  vpc_security_group_ids      = [aws_security_group.web.id]

  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.project}-app"
  }
}

resource "aws_key_pair" "instance_ssh" {
  key_name   = "${var.project}-ssh-key"
  public_key = file("./ssh_key/public_Key")
}

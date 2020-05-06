resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project}-vpc-2"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "${var.region}a"
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 10)

  tags = {
    Name = "${var.project}-public-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "${var.region}a"
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 20)

  tags = {
    Name = "${var.project}-private-subnet-1a"
  }
}

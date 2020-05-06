variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

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

# resource "aws_instance" "example" {
#     ami = "ami-0f310fced6141e627"
#     instance_type = "t2.micro"
#     tags = {
#         Name = "${var.project}-web"
#     }
# }

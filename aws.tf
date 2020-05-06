variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_vpc" "laravel_tweet_ddd" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "laravel-tweet-ddd-vpc-2"
  }
}

resource "aws_subnet" "laravel_tweet_ddd_public_subnet_1a" {
  vpc_id            = aws_vpc.laravel_tweet_ddd.id
  availability_zone = "ap-northeast-1a"
  cidr_block = cidrsubnet(aws_vpc.laravel_tweet_ddd.cidr_block, 8, 10)

  tags = {
    Name = "laravel-tweet-ddd-public-subnet-1a"
  }
}

resource "aws_subnet" "laravel_tweet_ddd_private_subnet_1a" {
  vpc_id            = aws_vpc.laravel_tweet_ddd.id
  availability_zone = "ap-northeast-1a"
  cidr_block = cidrsubnet(aws_vpc.laravel_tweet_ddd.cidr_block, 8, 20)

  tags = {
    Name = "laravel-tweet-ddd-private-subnet-1a"
  }
}

# resource "aws_instance" "example" {
#     ami = "ami-0f310fced6141e627"
#     instance_type = "t2.micro"
#     tags = {
#         Name = "laravel-tweet-ddd-web-2"
#     }
# }

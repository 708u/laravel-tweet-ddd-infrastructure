variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_vpc" "laravel-tweet-ddd" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "laravel-tweet-ddd-vpc-2"
  }
}

# resource "aws_instance" "example" {
#     ami = "ami-0f310fced6141e627"
#     instance_type = "t2.micro"
#     tags = {
#         Name = "laravel-tweet-ddd-web-2"
#     }
# }

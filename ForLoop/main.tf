provider "aws" {
  region = "us-east-1"
}


resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users)
  name     = each.value
}

resource "aws_instance" "my_server" {
  count         = 4
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  tags = {
    Name  = "Server-${count.index + 1}"
    Owner = "Chuksteve"
  }
}
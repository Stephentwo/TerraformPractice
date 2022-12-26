provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {} 

resource "aws_eip" "web" {
  vpc      = true  
  instance = aws_instance.web.id
  tags = {
    Name  = "EIP for WebServer Built by Terraform"
    Owner = "Chuksteve"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-0b5eea76982371e91" // Amazon Linux2
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data                   = file("user_data.sh") 
  user_data_replace_on_change = true                 
  tags = {
    Name  = "WebServer Built by Terraform"
    Owner = "chuksteve"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my WebServer"
  vpc_id      = aws_default_vpc.default.id 

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Chuksteve"
  }
}
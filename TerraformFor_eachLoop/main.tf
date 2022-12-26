provider "aws" {
  region = "us-east-1"
}

/*
resource "aws_instance" "my_server" {
  for_each      = toset(["Dev", "Staging", "Prod"])
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  tags = {
    Name  = "Server-${each.value}"
    Owner = "Chuksteve"
  }
}
*/

resource "aws_instance" "server" {
  for_each      = var.servers_settings
  ami           = each.value["ami"]
  instance_type = each.value["instance_size"]

  root_block_device {
    volume_size = each.value["root_disksize"]
    encrypted   = each.value["encrypted"]
  }

  volume_tags = {
    Name = "Disk-${each.key}"
  }
  tags = {
    Name  = "Server-${each.key}"
    Owner = "Chuksteve"
  }
}

resource "aws_instance" "bastion_server" {
  for_each      = var.create_bastion == "YES" ? toset(["bastion"]) : []
  ami           = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  tags = {
    Name  = "Bastion Server"
    Owner = "Chuksteve"
  }
}
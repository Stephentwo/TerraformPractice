variable "servers_settings" {
  type = map(any)
  default = {
    web = {
      ami           = "ami-0b5eea76982371e91"
      instance_size = "t2.micro"
      root_disksize = 20
      encrypted     = true
    }
    app = {
      ami           = "ami-0b5eea76982371e91"
      instance_size = "t2.micro"
      root_disksize = 10
      encrypted     = false
    }
  }
}


variable "create_bastion" {
  description = "Provision Bastion Server YES/NO"
  default     = "NO"
}
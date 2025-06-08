terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "aws_instance" "app_server" {
 ami		= "ami-04999cd8f2624f834"
 instance_type 	= "t2.large"
 key_name 	= "minecraft"
 subnet_id	= "subnet-0f116fa7a42d0a000"
 associate_public_ip_address = true

 provisioner "remote-exec" {
  script = "restart-w-reboot.sh"
 }

 connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/downloads/minecraft.pem")
    host        = self.public_ip 
 }


 tags = {
    Name = "Minecraft Server"
 }
}

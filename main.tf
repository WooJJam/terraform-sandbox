data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "terraform_sandbox" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

}

resource "aws_vpc" "sandbox_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sandbox-vpc"
  }
}
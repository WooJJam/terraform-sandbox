data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_vpc" "sandbox_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "sandbox-vpc"
  }
}

resource "aws_subnet" "sandbox_public_subnet" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sandbox-public-subnet"
  }
}

resource "aws_subnet" "sandbox_private_subnet_1" {
  vpc_id            = aws_vpc.sandbox_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "sandbox-private-subnet-1"
  }
}

resource "aws_subnet" "sandbox_private_subnet_2" {
  vpc_id            = aws_vpc.sandbox_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-northeast-2d"

  tags = {
    Name = "sandbox-private-subnet-2"
  }
}

resource "aws_internet_gateway" "sandbox_igw" {
  vpc_id = aws_vpc.sandbox_vpc.id

  tags = {
    Name = "sandbox-igw"
  }
}

resource "aws_route_table" "sandbox_public_route_table" {
  vpc_id = aws_vpc.sandbox_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sandbox_igw.id
  }

  tags = {
    Name = "sandbox-public-route-table"
  }
}

resource "aws_route_table" "sandbox_private_route_table" {
  vpc_id = aws_vpc.sandbox_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sandbox_public_nat_gw.id
  }

  tags = {
    Name = "sandbox-private-route-table"
  }
}

resource "aws_route_table_association" "sandbox_public_rta" {
  subnet_id      = aws_subnet.sandbox_public_subnet.id
  route_table_id = aws_route_table.sandbox_public_route_table.id
}

resource "aws_route_table_association" "sandbox_private_rta_1" {
  subnet_id      = aws_subnet.sandbox_private_subnet_1.id
  route_table_id = aws_route_table.sandbox_private_route_table.id
}

resource "aws_route_table_association" "sandbox_private_rta_2" {
  subnet_id      = aws_subnet.sandbox_private_subnet_2.id
  route_table_id = aws_route_table.sandbox_private_route_table.id
}

resource "aws_instance" "terraform_public_sandbox" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.sandbox_public_subnet.id

  tags = {
    Name = var.instance_name
  }

}

resource "aws_instance" "terraform_private_sandbox_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.sandbox_private_subnet_1.id

  tags = {
    Name = "terraform-private-sandbox-1"
  }

}

resource "aws_instance" "terraform_private_sandbox_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.sandbox_private_subnet_2.id

  tags = {
    Name = "terraform-private-sandbox-2"
  }

}

resource "aws_eip" "sandbox_eip" {
  domain = "vpc"

  tags = {
    Name = "sandbox-eip"
  }
}

resource "aws_nat_gateway" "sandbox_public_nat_gw" {
  allocation_id = aws_eip.sandbox_eip.id
  subnet_id     = aws_subnet.sandbox_public_subnet.id

  tags = {
    Name = "sandbox-public-nat-gw"
  }

  depends_on = [aws_internet_gateway.sandbox_igw]
}
resource "aws_vpc" "VPC" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-VPC"
  }
}

resource "aws_subnet" "PUBLIC-SUBNET" {
  count      = length(var.public_cidrs)
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.public_cidrs[count.index]
  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index+1}"
  }
}

resource "aws_subnet" "PRIVATE-SUBNET" {
  count      = length(var.private_cidrs)
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.private_cidrs[count.index]
  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index+1}"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "${var.vpc_name}-rt"
  }
}

resource "aws_route_table" "PRT" {
  vpc_id = aws_vpc.VPC.id
  
  tags = {
    Name = "${var.vpc_name}-prt"
  }
}

resource "aws_route_table_association" "RTA" {
  count = length(var.public_cidrs)
  subnet_id      = element(aws_subnet.PUBLIC-SUBNET.*.id,count.index)
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "PRTA" {
  count = length(var.private_cidrs)
  subnet_id      = element(aws_subnet.PRIVATE-SUBNET.*.id,count.index)
  route_table_id = aws_route_table.PRT.id
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
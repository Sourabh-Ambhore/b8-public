resource "aws_vpc" "tf-vpc" {
  cidr_block       = var.vpc_cidr #1024 IPs
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "custom-igw-for-vpc" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = var.custom_igw
  }
}

resource "aws_subnet" "pub-subnet" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = var.pub_sub_cidr #256 IPs
  map_public_ip_on_launch = var.pub_ip_enable 
  availability_zone = var.az
  tags = {
    Name = var.pub_sub_name
  }
}

resource "aws_subnet" "pri-subnet" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = var.pri_sub_cidr #256 IPs
  map_public_ip_on_launch = var.pub_ip_disable
  availability_zone       = var.az_pri_sub
  tags = {
    Name = var.pri_sub_name
  }
}

resource "aws_route_table" "custom-default-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = var.cidr_rt
    gateway_id = aws_internet_gateway.custom-igw-for-vpc.id
  }
  tags = {
    Name = var.default_rt_name
  }
}

resource "aws_route_table_association" "custom-public-rt-association" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.custom-default-rt.id
}

resource "aws_eip" "custom-eip-for-vpc" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.custom-igw-for-vpc]
}

resource "aws_nat_gateway" "custom-nat-for-vpc" {
  allocation_id = aws_eip.custom-eip-for-vpc.id
  subnet_id     = aws_subnet.pub-subnet.id

  tags = {
    Name = var.nat_name
  }
  depends_on = [aws_internet_gateway.custom-igw-for-vpc]
}

resource "aws_route_table" "custom-pri-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block     = var.cidr_rt
    nat_gateway_id = aws_nat_gateway.custom-nat-for-vpc.id
  }
  tags = {
    Name = var.custom_rt_name
  }
}

resource "aws_route_table_association" "custom-nat-rt-association" {
  subnet_id      = aws_subnet.pri-subnet.id
  route_table_id = aws_route_table.custom-pri-rt.id
}
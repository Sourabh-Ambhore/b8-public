##VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block       = "192.168.0.0/22" #1024 IPs
  instance_tenancy = "default"

  tags = {
    Name = "custom-vpc-created-by-tf"
  }
}

##IGW 
resource "aws_internet_gateway" "custom-igw-for-vpc" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "custom-igw-for-vpc"
  }
}

##subnets##
resource "aws_subnet" "pub-subnet" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "192.168.1.0/24" #256 IPs
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "custom-public-subnet"
  }
}

resource "aws_subnet" "pri-subnet" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "192.168.2.0/24" #256 IPs
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  tags = {
    Name = "custom-private-subnet"
  }
}

##Default Route Table
resource "aws_route_table" "custom-default-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom-igw-for-vpc.id
  }
  tags = {
    Name = "custom-default-rt"
  }
}

## Route table association
resource "aws_route_table_association" "custom-public-rt-association" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.custom-default-rt.id
}

## elastic IP
resource "aws_eip" "custom-eip-for-vpc" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.custom-igw-for-vpc]
}

resource "aws_nat_gateway" "custom-nat-for-vpc" {
  allocation_id = aws_eip.custom-eip-for-vpc.id
  subnet_id     = aws_subnet.pub-subnet.id

  tags = {
    Name = "custom-nat-for-vpc"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.custom-igw-for-vpc]
}

## RT for NAT
resource "aws_route_table" "custom-pri-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom-nat-for-vpc.id
  }
  tags = {
    Name = "custom-nat-rt"
  }
}

resource "aws_route_table_association" "custom-nat-rt-association" {
  subnet_id      = aws_subnet.pri-subnet.id
  route_table_id = aws_route_table.custom-pri-rt.id
}


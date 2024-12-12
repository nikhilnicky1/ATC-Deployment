# webapp_vpc.tf
resource "aws_vpc" "webapp_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "webapp_vpc"
  }
}

# Public Subnets
resource "aws_subnet" "webapp_public_subnet_a" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "webapp_public_subnet_a"
  }
}

resource "aws_subnet" "webapp_public_subnet_b" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "webapp_public_subnet_b"
  }
}

# Private Subnets
resource "aws_subnet" "webapp_private_subnet_a" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "webapp_private_subnet_a"
  }
}

resource "aws_subnet" "webapp_private_subnet_b" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "webapp_private_subnet_b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "webapp_igw" {
  vpc_id = aws_vpc.webapp_vpc.id
}

# Public Route Table
resource "aws_route_table" "webapp_public_rt" {
  vpc_id = aws_vpc.webapp_vpc.id
}

resource "aws_route" "webapp_internet_access" {
  route_table_id         = aws_route_table.webapp_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.webapp_igw.id
}

resource "aws_route_table_association" "webapp_public_subnet_a" {
  subnet_id      = aws_subnet.webapp_public_subnet_a.id
  route_table_id = aws_route_table.webapp_public_rt.id
}

resource "aws_route_table_association" "webapp_public_subnet_b" {
  subnet_id      = aws_subnet.webapp_public_subnet_b.id
  route_table_id = aws_route_table.webapp_public_rt.id
}

# Private Route Table
resource "aws_route_table" "webapp_private_rt" {
  vpc_id = aws_vpc.webapp_vpc.id
}

# Create a NAT Gateway for private subnets (optional, if you need outbound internet access for private subnets)
resource "aws_eip" "webapp_nat_eip" {}

resource "aws_nat_gateway" "webapp_nat_gw" {
  allocation_id = aws_eip.webapp_nat_eip.id
  subnet_id     = aws_subnet.webapp_public_subnet_a.id
}

resource "aws_route" "webapp_nat_route" {
  route_table_id         = aws_route_table.webapp_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.webapp_nat_gw.id
}

resource "aws_route_table_association" "webapp_private_subnet_a" {
  subnet_id      = aws_subnet.webapp_private_subnet_a.id
  route_table_id = aws_route_table.webapp_private_rt.id
}

resource "aws_route_table_association" "webapp_private_subnet_b" {
  subnet_id      = aws_subnet.webapp_private_subnet_b.id
  route_table_id = aws_route_table.webapp_private_rt.id
}
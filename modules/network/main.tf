# Create a VPC
resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}_VPC-${var.workspace}"
  }
}

#Create Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-Public-Subnet ${count.index + 1}-${var.workspace}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs) == 0 ? 0 : length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-Private-Subnet ${count.index + 1}-${var.workspace}"
  }
}

#Create Nat Gateway
resource "aws_nat_gateway" "NATgw" {
  count         = length(aws_subnet.public_subnets)
  allocation_id = aws_eip.NatEIP[count.index].id
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
}

#Create IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "${var.name}_VPC IGW-${var.workspace}"
  }
}

#Create Elastic IP
resource "aws_eip" "NatEIP" {
  domain = "vpc"
  count  = length(aws_subnet.public_subnets)

  tags = {
    Name = "eip-${count.index + 1}-${var.workspace}"
  }
}


#Create public Route table
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }


  tags = {
    Name = "public_RT-${var.workspace}"
  }
}

#Associate public subnets to created router table
resource "aws_route_table_association" "PublicRTassociation" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_RT.id
}

# Create private Route table
resource "aws_route_table" "private_RT" {
  count  = length(aws_subnet.private_subnets)
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.NATgw[*].id, count.index)
  }

  tags = {
    Name = "private_RT-${element([for subnet in aws_subnet.private_subnets : subnet.tags["Name"]][*], count.index)}"
  }
}

#Associate private subnet to private Route table 
resource "aws_route_table_association" "PrivateRTassociation" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_RT[count.index].id
}

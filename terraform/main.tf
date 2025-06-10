# VPC
resource "aws_vpc" "k8s_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "k8s-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "k8s-igw"
  }
}

# Public Subnet in AZ1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = var.public_subnet_az1
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-az1"
  }
}

# Public Subnet in AZ2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = var.public_subnet_az2
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-az2"
  }
}

# Route Table
resource "aws_route_table" "k8s_public_rt" {
  vpc_id = aws_vpc.k8s_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }
  tags = {
    Name = "k8s-public-rt"
  }
}

# Route Table Association for AZ1
resource "aws_route_table_association" "public_rt_assoc_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.k8s_public_rt.id
}

# Route Table Association for AZ2
resource "aws_route_table_association" "public_rt_assoc_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.k8s_public_rt.id
}

# Security Group
resource "aws_security_group" "k8s_admin_sg" {
  name        = "k8s-admin-sg"
  description = "Allow SSH, HTTP, HTTPS"
  vpc_id      = aws_vpc.k8s_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-admin-sg"
  }
}

# EC2 Admin Host (KOPS Control)
resource "aws_instance" "kops_admin" {
  ami           = "ami-0b28354031edf7b09" # Amazon Linux 2 (us-east-2)
  instance_type = "t2.small"
  subnet_id     = aws_subnet.public_subnet_az1.id
  key_name      = "project2-key"
  security_groups = [aws_security_group.k8s_admin_sg.id]

  tags = {
    Name = "kops-admin"
  }
}

# S3 Bucket for KOPS State Store
resource "aws_s3_bucket" "kops_state_store" {
  bucket = "kops-cluster-state-store-habib"

  versioning {
    enabled = true
  }

  tags = {
    Name = "kops-state-store"
  }
}


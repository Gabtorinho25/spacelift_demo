terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
  access_key="ASIATE2QE3YDPTWUY55F"  
  secret_key="mjf3hit+2tllp98i09jZfk5gKpYQZeDMErEZPlz1"
  token="IQoJb3JpZ2luX2VjEIP//////////wEaCXVzLXdlc3QtMiJHMEUCIEjBZn2c/+x2VqwzzqJjgy61cwT0U1ggUkz2gpbB8h1iAiEA52NxfkC4eCIh29vb+HcK9liCudkB1lcjEAolw5QkWZkqrAIIXBAAGgwyMTY1MjcwNjg2NzgiDGhoFKbFTF/Q9Et52SqJAvnyhooPzY5i1aA/K+WuRApXhUy9MKfKRS70gZo4nYGu1kRlpzs1o7sIZDMs7A4mI2ZiJ1koD20woK1mm5f9fSeEMy3kPJqtz+8fISRiXoJay/Qnn8unBJZO86I10kBmC4jpOm9+1rDGoLBw7JHFquiZZlD7AmbQfInLOYjA0VLOlI05V4EPzkuNK0as0L6C72PR4iEM+QD5NiPTQ2Prq/pqKWJ6ksNhGdrxB9Sn3i15qAn/pc/9MZZQ0BoZzsFTQapjhdvYkr1peP51X8Os2IjCqplu39DkWpQ6xvij5L2k8efGJjsDS4T6gNoqZlTJs5mdeTqvgSeg5qdvrTxRssAE0ZXsxMAIGYkwu4OLwgY6nQHG+XvYmDEcQ0iRC82Q2Y89SHjVBR774oxr5rWxOSAecIoYwgIlVWQKCKhLEDt5ECduIsOcBjcwarR1A+ISdx4S6UlRFps4F0mDxgoa0FYy0Bl3kra3NuGsT1MLHysv0qs8ZrrARovBTa92MOvkLDDVwZEd1ZO3pl77cTI3Rzl2jRAWFZL51/LQedsQmSdfzODNcHfzHSVeZjX+Ygxm"
}

# Create SSH Key Pair from provided public key
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = var.ssh_public_key
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main-vpc"
  }
}

# Subnets
resource "aws_subnet" "web" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "web-subnet"
  }
}

resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.app_subnet_cidr

  tags = {
    Name = "app-subnet"
  }
}

resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_subnet_cidr

  tags = {
    Name = "db-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Route Table and Association
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "web" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.public.id
}

# Security Groups
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "web-sg"
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

# EC2 Instances
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.web.id
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "web-instance"
  }
}

resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.app.id
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "app-instance"
  }
}

resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.db.id
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "db-instance"
  }
}

# Output IPs
output "web_public_ip" {
  value = aws_instance.web.public_ip
}

output "app_private_ip" {
  value = aws_instance.app.private_ip
}

output "db_private_ip" {
  value = aws_instance.db.private_ip
}

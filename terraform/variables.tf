variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "key_name" {
  description = "Name for the SSH key pair"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
}

variable "my_public_ip" {
  description = "Your IP address (x.x.x.x/32) to allow SSH access"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "app_subnet_cidr" {
  description = "CIDR block for the app subnet"
  type        = string
}

variable "db_subnet_cidr" {
  description = "CIDR block for the DB subnet"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

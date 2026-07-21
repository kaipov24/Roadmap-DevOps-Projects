variable "aws_region" {
  description = "AWS region where the EC2 instance and network will be created."
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet."
  type        = string
  default     = "us-east-1a"
}

variable "project_name" {
  description = "Name prefix used for AWS resource tags."
  type        = string
  default     = "multi-container-application"
}

variable "environment" {
  description = "Environment tag for the EC2 instance."
  type        = string
  default     = "Production"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the application VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.0.0/24"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the EC2 instance. Use your public IP with /32."
  type        = string
  default     = "212.112.118.83/32"
}

variable "api_port" {
  description = "Public EC2 port allowed for the API container."
  type        = number
  default     = 3001
}

variable "instance_type" {
  description = "EC2 instance type for the API host."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name used for SSH and Ansible."
  type        = string
  default     = "ssh-test"
}

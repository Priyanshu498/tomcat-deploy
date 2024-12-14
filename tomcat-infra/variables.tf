# VPC Configuration
variable "cidr_block" {
  default = "172.16.0.0/22"
}

variable "aws_vpc" {
  default = "my-vpc"
}

# Subnets Configuration
variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["172.16.0.0/24", "172.16.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["172.16.2.0/24", "172.16.3.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

# Tags for Resources
variable "tags" {
  type    = map(string)
  default = {}
}

# EC2 Instance Configuration
variable "ami_id" {
  default = "ami-0614680123427b75e"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
  default = "public"
}

variable "key_name" {
  default = "new-key"
}

variable "security_group_name" {
  default = "Tom-SG"
}

# Security Group Configuration
variable "ingress_ports" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 0        
      to_port     = 0        
      protocol    = "-1"     
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_ports" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "desired_capacity" {
  default = "2"
}

variable "max_size" {
  default = "3"
}

variable "min_size" {
  default = "1"
}

variable "port" {
  default = "8080"
}

variable "listener_port" {
  default = "80"
}

# VPC Peering Configuration
variable "region_name" {
  type = string
  default = "ap-south-1"
}

variable "vpc_peering_name" {
  type = string
  default = "tom_peering"
}

variable "cidr_range" {
  type = string
  default = "172.31.0.0/16"
}

variable "default_vpc_cidr" {
  type = string
  default = "172.31.0.0/16"
}

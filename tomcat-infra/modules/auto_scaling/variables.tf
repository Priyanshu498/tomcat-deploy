variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}
variable "security_group_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "target_group_arn" {
  type = string
}

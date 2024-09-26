variable "security_group_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "port" {
  type = number
}

variable "listener_port" {
  type = number
}



resource "aws_internet_gateway" "IGW" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { "Name" = "Internet Gateway" })
}

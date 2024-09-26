resource "aws_nat_gateway" "NAT" {
  allocation_id = var.eip_allocation_id
  subnet_id     = var.subnet_id
  tags          = merge(var.tags, { "Name" = "NAT Gateway" })
}

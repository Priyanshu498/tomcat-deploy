resource "aws_instance" "public_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name       = var.key_name

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "Public-Server"
  }
}

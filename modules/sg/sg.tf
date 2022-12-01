resource "aws_security_group" "aws_sg" {
  name        = "aws_sg-${var.name}"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.sg_vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "tcp"
    cidr_blocks      = var.sg_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "cmtr-ouv17nh6-ssh-sg"
  description = "SSH Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Project = "cmtr-ouv17nh6"
  }
}

resource "aws_security_group_rule" "ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh_sg.id
}

resource "aws_security_group_rule" "ssh_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh_sg.id
}

resource "aws_security_group" "public_http_sg" {
  name        = "cmtr-ouv17nh6-public-http-sg"
  description = "Public HTTP Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Project = "cmtr-ouv17nh6"
  }
}

resource "aws_security_group_rule" "public_http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http_sg.id
}

resource "aws_security_group_rule" "public_http_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http_sg.id
}

resource "aws_security_group" "private_http_sg" {
  name        = "cmtr-ouv17nh6-private-http-sg"
  description = "Private HTTP Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Project = "cmtr-ouv17nh6"
  }
}

resource "aws_security_group_rule" "private_http_rule" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}

resource "aws_security_group_rule" "private_http_icmp" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}

data "aws_instance" "public_instance" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private_instance" {
  instance_id = var.private_instance_id
}

resource "aws_network_interface_sg_attachment" "public_ssh_attach" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_instance.public_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "public_http_attach" {
  security_group_id    = aws_security_group.public_http_sg.id
  network_interface_id = data.aws_instance.public_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_ssh_attach" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_instance.private_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_http_attach" {
  security_group_id    = aws_security_group.private_http_sg.id
  network_interface_id = data.aws_instance.private_instance.network_interface_id
}
output "ssh_sg_id" {
  description = "SSH Security Group ID"
  value       = aws_security_group.ssh_sg.id
}

output "public_http_sg_id" {
  description = "Public HTTP Security Group ID"
  value       = aws_security_group.public_http_sg.id
}

output "private_http_sg_id" {
  description = "Private HTTP Security Group ID"
  value       = aws_security_group.private_http_sg.id
}
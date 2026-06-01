variable "allowed_ip_range" {
  description = "List of allowed IP ranges"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_instance_id" {
  description = "Public EC2 instance ID"
  type        = string
}

variable "private_instance_id" {
  description = "Private EC2 instance ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}
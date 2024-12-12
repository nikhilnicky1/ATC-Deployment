variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t3.medium"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be deployed"
}

variable "subnet_id" {
  description = "The ID of the subnet where resources will be deployed"
}



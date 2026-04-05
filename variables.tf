variable "instance_name" {
  description = "EC2 instances' name tag"
  type        = string
  default     = "rraform-sandbox-instance"
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3.micro"
}

variable "seoul_region" {
  description = "Seoul region"
  type = string
  default = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type = string
  default = "10.0.0.0/16"
}
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
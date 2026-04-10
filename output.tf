output "instance_public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.terraform_public_sandbox
}

output "instance_hostname" {
  description = "Hostname of the instance"
  value       = aws_instance.terraform_public_sandbox.public_dns
}

output "vpc_cidr" {
  description = "cidr of the vpc"
  value       = aws_vpc.sandbox_vpc.cidr_block
}

output "vpc__owner_id" {
  description = "owner_id of the vpc"
  value       = aws_vpc.sandbox_vpc.owner_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.sandbox_public_subnet.id
}
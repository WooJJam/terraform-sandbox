output "instance_public_ip" {
    description = "Public IP of the instance"
    value = aws_instance.terraform_sandbox.public_ip
}

output "instance_hostname" {
    description = "Hostname of the instance"
    value = aws_instance.terraform_sandbox.public_dns
}

output "vpc_cidr" {
    description = "cidr of the vpc"
    value = aws_vpc.sandbox_vpc.cidr_block
}

output "vpc__owner_id" {
    description = "owner_id of the vpc"
    value = aws_vpc.sandbox_vpc.owner_id
}
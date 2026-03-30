output "instance_public_ip" {
    description = "Public IP of the instance"
    value = aws_instance.terraform_sandbox.public_ip
}

output "instance_hostname" {
    description = "Hostname of the instance"
    value = aws_instance.terraform_sandbox.public_dns
}
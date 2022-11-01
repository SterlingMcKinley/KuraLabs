output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "public_subnet_az1_id" {
    value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
    value = aws_subnet.public_subnet_az2.id
}

output "internet_gateway" {
    value = aws_internet_gateway.internet_gateway
}

output "security_group" {
    value = [aws_security_group.web_ssh.id]
}
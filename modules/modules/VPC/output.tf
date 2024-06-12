output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "internet_gateway" {
    value = aws_internet_gateway.internet_gateway
  
}
output "pub_sub_1a_id" {
    value = aws_subnet.pub_sub_1a.id
}

output "project_name" {
    value = var.project_name
}
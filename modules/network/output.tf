output "vpc_id" {
    value = aws_vpc.VPC.id
}
output "vpc_name" {
    value = aws_subnet.private_subnets.*.id
}
output "vpc_cidr" {
    value = aws_vpc.VPC.cidr_block
}
output "public_subnets_ids" {
    value = aws_subnet.public_subnets.*.id
}
output "private_subnets_ids" {
    value = aws_subnet.private_subnets.*.id
}
output "public_route_table_ids" {
    value = aws_route_table.public_RT.*.id
}
output "private_route_table_ids" {
    value = aws_route_table.private_RT.*.id
}

output "eips" {
  value= aws_eip.NatEIP.*.id
}
output "igw" {
  value = aws_internet_gateway.IGW.id
}
output "NATgws" {
    value = aws_nat_gateway.NATgw.*.id
}
output "azs" {
    value = var.azs
}
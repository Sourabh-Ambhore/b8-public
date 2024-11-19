output "custom_output" {
  value = aws_eip.custom-eip-for-vpc.public_ip
}

output "vpc_id" {
  value = aws_vpc.tf-vpc.id
}

output "igw_arn" {
  value = aws_internet_gateway.custom-igw-for-vpc.arn
}
output "vpc_name" {
  value = aws_vpc.tf-vpc.tags
}

output "vpc_arn" {
  value = aws_vpc.tf-vpc.arn
}

output "vpc_id" {
  value = aws_vpc.tf-vpc.id
}

output "pubsub" {
  value = aws_subnet.pub-subnet.cidr_block
}

output "pubsub_az" {
  value = aws_subnet.pub-subnet.availability_zone
}

output "pri_subnet_cide" {
  value = aws_vpc.tf-vpc.cidr_block
}
output "s3_bucket_name" {
  value = aws_s3_bucket.aws_s3_bucket.bucket_domain_name
}

output "buckt_arn" {
  value = aws_s3_bucket.aws_s3_bucket.arn
}

output "tags" {
  value = aws_s3_bucket.aws_s3_bucket.tags
}
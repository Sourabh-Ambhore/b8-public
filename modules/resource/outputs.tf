output "bucket_name" {
  value = module.s3_bucket.s3_bucket_name
}

output "arn" {
  value = module.s3_bucket.buckt_arn
}

output "s3_tag" {
  value = module.s3_bucket.tags
}
# resource "aws_s3_bucket" "count-resource" {
#   count  = 3
#  # bucket = "wakad-b8-25-11-2024-${count.index + 1}"
#  bucket = var.bucket_name[count.index]
#   tags = {
#     Name        = "My tf created bucket"
#     Environment = "Dev"
#   }
# }

resource "aws_s3_bucket" "state-bucket" {
  bucket = "wakad-b8-state-bucket-25-11"
  tags = {
    purpose = "for tf state"
  }
}

resource "aws_s3_bucket" "for-each-resource" {
  for_each = toset(var.bucket_name)
  bucket = each.value
}
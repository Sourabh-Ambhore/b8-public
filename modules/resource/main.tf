module "s3_bucket" {
  source = "../module"
  b_name = var.calling_bucket_name
  force_destroy = var.force_destroy
  object_lock = var.object_lock
}

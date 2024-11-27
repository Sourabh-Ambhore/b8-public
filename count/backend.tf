terraform {
  backend "s3" {
    bucket     = "terraform-backup-bct"
    key        = "b8/s3/dev/terraform.tfstate"
    region     = "us-east-1"

  }
}


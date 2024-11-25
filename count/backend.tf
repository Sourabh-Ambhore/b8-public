terraform {
  backend "s3" {
    bucket     = "wakad-b8-state-bucket-25-11"
    key        = "s3/dev/terraform.tfstate"
    region     = "us-east-1"
    ## add access keys 
  }
}
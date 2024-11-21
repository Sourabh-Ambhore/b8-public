variable "b_name" {
  type = string
  description = "name of s3 bucket"
}

variable "force_destroy" {
  type = bool
}

variable "object_lock" {
  type = bool
}
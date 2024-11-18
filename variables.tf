variable "sgname" {
  type = string
  default = "my-sg-terraform"
}

variable "description" {
  type = string
  default = "Securtiy Group Created by terraform for ssh, http and https"
}

variable "myvpcid" {
  type = string
  default = "vpc-05582e694b9155ad3"
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "custom_igw" {
  type = string
}

variable "pub_sub_cidr" {
  type = string
}

variable "pub_ip_enable" {
type = bool
default = true
}

variable "az" {
  type = string
}

variable "pub_sub_name" {
  type = string
}

variable "pri_sub_cidr" {
 type = string
}

variable "pub_ip_disable" {
 type = string
 default = false 
}

variable "az_pri_sub" {
  type = string
}

variable "pri_sub_name" {
  type = string
}

variable "cidr_rt" {
  type = string
}

variable "default_rt_name" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "custom_rt_name" {
  type = string
}
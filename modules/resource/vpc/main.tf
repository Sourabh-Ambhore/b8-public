module "vpc" {
  source          = "../../module/vpc-module"
  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  custom_igw      = var.custom_igw
  pub_sub_cidr    = var.pub_sub_cidr
  pub_ip_enable   = var.pub_ip_enable
  az              = var.az
  pub_sub_name    = var.pub_sub_name
  pri_sub_cidr    = var.pri_sub_cidr
  pub_ip_disable  = var.pub_ip_disable
  az_pri_sub      = var.az_pri_sub
  pri_sub_name    = var.pri_sub_name
  cidr_rt         = var.cidr_rt
  default_rt_name = var.default_rt_name
  nat_name        = var.nat_name
  custom_rt_name  = var.custom_rt_name
}
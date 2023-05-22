module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "onprem-migration-vpc"
  cidr = var.vpc_cidr

  azs              = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)
  # public_subnets   = cidrsubnet(var.vpc_cidr, 2, 1)
  # database_subnets  = cidrsubnet(var.vpc_cidr, 4, 1)
  private_subnets = [for i, v in local.availability-zones : cidrsubnet(local.private_subnet_cidr, 1, i)]
  public_subnets   = [for i, v in local.availability-zones : cidrsubnet(local.public_subnet_cidr, 1, i)]
  # database_subnet_group_name = var.database_subnetgrp_name
  enable_nat_gateway = true
  #enable_vpn_gateway = true
  single_nat_gateway = true
  private_subnet_tags = {Name = "subnet-database"}
  public_subnet_tags = {Name = "subnet-public"}
  tags = {
    Terraform   = "true"
    Environment = "onprem"
  }
}

#[for i, v in ["eu-west-1a", "eu-west-1b"] : cidrsubnet("10.0.16.0/20", 4, i)]
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
  map_public_ip_on_launch = true
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

resource "aws_eip" "web_eip" {
  vpc = true
  tags = {
    Name   = "webserver-eip"
  }
}
# resource "aws_network_interface" "db" {
#   subnet_id       = module.vpc.private_subnets[0]
#   # private_ips     = ["10.0.0.50"]
#   # security_groups = [aws_security_group.onprem_database_sg.id]
#   description = "db-test"
#   # attachment {
#   #   instance     = aws_instance.onprem_database_server.id
#   #   device_index = 0
#   # }
# }

# resource "aws_network_interface" "web" {
#   subnet_id       = module.vpc.public_subnets[0]
#   # private_ips     = ["10.0.0.50"]
#   # security_groups = [aws_security_group.onprem_database_sg.id]
#   description = "web-test"
#   # attachment {
#   #   instance     = aws_instance.onprem_database_server.id
#   #   device_index = 0
#   # }
# }
#[for i, v in ["eu-west-1a", "eu-west-1b"] : cidrsubnet("10.0.16.0/20", 4, i)]
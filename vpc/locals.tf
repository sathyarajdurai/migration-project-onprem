locals {
  availability-zones = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)

  public_subnet_cidr   = cidrsubnet(var.vpc_cidr, 2, 1)
  private_subnet_cidr  = cidrsubnet(var.vpc_cidr, 4, 1)
  
}

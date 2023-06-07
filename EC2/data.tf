# data "aws_secretsmanager_secret" "rds_sce" {
#   name = "myaddress"
# }

# data "aws_secretsmanager_secret_version" "rds_pass" {
#   secret_id     = data.aws_secretsmanager_secret.rds_sce.id
# }

data "aws_key_pair" "onprem_key" {
    key_name           = "onprem-us"
    # key_pair_id = "key-0746d429c1bcd7b10"
    include_public_key = true

  
}


# data "aws_ami" "euwest1_ami" {

#     filter {
#     name   = "name"
#     # values = ["ami-01dd271720c1ba44f"]
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230517"]
#     }
#     most_recent = true
#     owners = ["099720109477"]
# }

data "aws_ami" "useast1_ami" {

    filter {
    name   = "name"
    # values = ["ami-01dd271720c1ba44f"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230517"]
    }
    most_recent = true
    owners = ["099720109477"]
}

data "aws_subnet"  "public_subnet" {
    # availability_zone = "eu-west-1a"
    filter {
    name   = "tag:Name"
    values = ["subnet-public"]
    }
     

}

data "aws_subnet"  "database_subnet" {
    # availability_zone = "eu-west-1a"
    filter {
    name   = "tag:Name"
    values = ["subnet-database"]
    }
}

data "aws_vpc" "vpc_id" {
    filter {
        name = "tag:Name"
        values = ["onprem-migration-vpc"]
    }
}

data "aws_eip" "eip"{ 
    filter {
    name   = "tag:Name"
    values = ["webserver-eip"]
  }
}





# data "aws_network_interface" "bar" {
#   description = "db-test"
# #   vpc_id = data.aws_vpc.vpc_id.id
# }

# data "aws_network_interface" "web_test" {
#   description = "web-test"
# #   vpc_id = data.aws_vpc.vpc_id.id
# }
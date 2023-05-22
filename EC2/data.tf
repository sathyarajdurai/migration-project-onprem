data "aws_secretsmanager_secret" "pub_ip" {
  name = "myaddress"
}

data "aws_secretsmanager_secret_version" "by_cidr" {
  secret_id     = data.aws_secretsmanager_secret.pub_ip.id
}

data "aws_key_pair" "onprem_key" {
    key_name           = "on-prem"
    # key_pair_id = "key-0746d429c1bcd7b10"
    include_public_key = true

  
}


data "aws_ami" "euwest1_ami" {

    filter {
    name   = "name"
    # values = ["ami-09fd16644beea3565"]
    values = ["al2023-ami-*"]
    }
    most_recent = true
    owners = ["137112412989"]
}

data "aws_subnet"  "public_subnet" {
    availability_zone = "eu-west-1a"
    filter {
    name   = "tag:Name"
    values = ["subnet-public"]
    }
     

}

data "aws_subnet"  "database_subnet" {
    availability_zone = "eu-west-1b"
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
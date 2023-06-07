resource "aws_security_group" "onprem_webserver_sg" {
  name        = "onprem-webserver"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.vpc_id.id

  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # ingress {
  #   description      = "Allow port 443"
  #   from_port        = 443
  #   to_port          = 443
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description      = "Allow port 1500"
  #   from_port        = 1500
  #   to_port          = 1500
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["103.28.246.192/32"]
    # cidr_blocks      = [jsondecode(data.aws_secretsmanager_secret_version.rds_pass.secret_string).myaddress1]
  }

  egress {
    description      = "Allow all port"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "onprem-webserver"
  }
}

resource "aws_security_group" "onprem_database_sg" {
  depends_on = [ aws_security_group.onprem_webserver_sg ]
  name        = "onprem-database"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.vpc_id.id

  ingress {
    description      = "Allow port 3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.onprem_webserver_sg.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description      = "Allow port 3306"
  #   from_port        = 3306
  #   to_port          = 3306
  #   protocol         = "tcp"
  #   # cidr_blocks      = ["10.0.26.29/32"]
  #   cidr_blocks      = [join("/", [data.terraform_remote_state.state1.outputs.ip, "32"])]
  # }

  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["103.28.246.192/32"]
    # cidr_blocks      = [jsondecode(data.aws_secretsmanager_secret_version.rds_pass.secret_string).myaddress1]
  }

  egress {
    description      = "Allow outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "onprem-database"
  }
}
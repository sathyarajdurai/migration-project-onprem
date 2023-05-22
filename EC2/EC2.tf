resource "aws_instance" "onprem_database_server" {
  
  ami           = data.aws_ami.euwest1_ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.onprem_database_sg.id]
  key_name = data.aws_key_pair.onprem_key.key_name
  subnet_id = data.aws_subnet.database_subnet.id
  # user_data = <<EOF
  # #!/bin/bash
  # sudo su apt-get update
  
  # EOF

  tags = {
    Name = "database-Server"
  }
}

resource "aws_instance" "onprem_web_server" {
  
  ami           = data.aws_ami.euwest1_ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.onprem_webserver_sg.id]
  key_name = data.aws_key_pair.onprem_key.key_name
  subnet_id = data.aws_subnet.public_subnet.id
  # user_data = <<EOF
  # #!/bin/bash
  # sudo su apt-get update
  
  # EOF
  

  tags = {
    Name = "webserver-Server"
  }
}
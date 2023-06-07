resource "aws_instance" "onprem_database_server" {
  # checkov:skip=BC_AWS_GENERAL_68: ADD REASON
  ami           = data.aws_ami.useast1_ami.id
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.onprem_database_sg.id]
  key_name = data.aws_key_pair.onprem_key.key_name
  subnet_id = data.aws_subnet.database_subnet.id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.id
  # private_ip = aws_network_interface.db.private_ip
  user_data = templatefile("${path.module}/database.sh.tpl",{
    mysql_root_password = var.mysql_root_password
    app_private_ip = aws_network_interface.web.private_ip
    
  })
  tags = {
    Name = "database-Server"
  }
}
# resource "aws_network_interface" "db" {
#   subnet_id       = data.aws_subnet.database_subnet.id
#   # private_ips     = ["10.0.0.50"]
#   security_groups = [aws_security_group.onprem_database_sg.id]
#   description = "db-test"
#   # attachment {
#   #   instance     = aws_instance.onprem_database_server.id
#   #   device_index = 0
#   # }
# }

# resource "aws_network_interface_attachment" "dbtest" {
#   instance_id          = aws_instance.onprem_database_server.id
#   network_interface_id = aws_network_interface.db.id
#   device_index         = 1
# }
resource "aws_instance" "onprem_web_server" {
  depends_on = [ aws_instance.onprem_database_server]
  ami           = data.aws_ami.useast1_ami.id
  instance_type = "t3.small"
  # vpc_security_group_ids = [aws_security_group.onprem_webserver_sg.id]
  key_name = data.aws_key_pair.onprem_key.key_name
  # subnet_id = data.aws_subnet.public_subnet.id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.id
  # associate_public_ip_address = true
  network_interface {
    network_interface_id = aws_network_interface.web.id
    device_index = 0
    
  }
  user_data = templatefile("${path.module}/webserver.sh.tpl",{
    mysql_root_password = var.mysql_root_password
    db_private_ip = aws_instance.onprem_database_server.private_ip
  })

  tags = {
    Name = "webserver-Server"
  }
}

resource "aws_network_interface" "web" {
  subnet_id       = data.aws_subnet.public_subnet.id
  security_groups = [aws_security_group.onprem_webserver_sg.id]
  description = "web-test"
  # attachment {
  #   instance     = aws_instance.onprem_web_server.id
  #   device_index = 0
  # }
}

# resource "aws_network_interface_attachment" "webtest" {
#   instance_id          = aws_instance.onprem_web_server.id
#   network_interface_id = aws_network_interface.web.id
#   device_index         = 1
# }



resource "aws_eip_association" "eip_assoc" {
#   depends_on = [ aws_instance.onprem_web_server ]
    instance_id   = aws_instance.onprem_web_server.id
#   # private_ip_address = aws_network_interface.web.private_ip
    allocation_id = data.aws_eip.eip.id
#   network_interface_id = aws_network_interface.web.id
}
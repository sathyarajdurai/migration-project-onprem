output "id" {
  value = data.aws_key_pair.onprem_key.id
}

# output "arn" {
#   value = data.aws_dms_replication_instance.ip_rep.replication_instance_arn
# }

# data "terraform_remote_state" "state1" {
#   backend = "s3" 
#   config = {
#     bucket         = "talent-academy-sathyaraj-lab-tfstates2"
#     key            = "talent-academy/migration-lab-rds/terraform.tfstates"
#     dynamodb_table = "terraform-lock"
#   }
# }

# output "ip" {
#   value = data.terraform_remote_state.state1.outputs.ip
# }

# rep_private_ip = data.terraform_remote_state.state1.outputs.ip #var.replication_inst_ip 

# replication_server_ip="${rep_private_ip}"

# mysql -u root -p$DB_ROOT_PASS -e "CREATE USER 'phpmyadmin'@'10.0.26.104' IDENTIFIED BY 'sathya@123';"
# mysql -u root -p$DB_ROOT_PASS -e "GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'phpmyadmin'@'10.0.26.104' WITH GRANT OPTION; FLUSH PRIVILEGES;"
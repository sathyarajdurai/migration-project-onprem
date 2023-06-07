

# locals {
#   mysql_root_password = jsondecode(data.aws_secretsmanager_secret_version.rds_pass.secret_string).rdspassword
# }
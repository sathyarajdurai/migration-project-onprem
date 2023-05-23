terraform {
  backend "s3" {
    bucket         = "talent-academy-sathyaraj-lab-tfstates2"
    key            = "talent-academy/migration-lab-onprem-ec2/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}
terraform {
  backend "s3" {
    bucket         = "talent-academy-sathyaraj-lab-tfstates3"
    key            = "talent-academy/migration-lab-onprem-vpc/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}
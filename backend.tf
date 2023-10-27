# NOTE:
# S3 backend. Terraform backends are used to store the filestate configuration ,
# which is crucial for tracking and managing the resources created or modified using Terraform.
# if you want to store the configuration in local folder Comment this whole file  
terraform {
  backend "s3" {
    bucket         = "aws-terraform-statefile"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "aws-terraform-locks_state"
  }
}
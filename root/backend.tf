terraform {
  backend "s3" {
    bucket         = "twotier-s3-backend"
    key            = "backend/twotier-terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "twotier-db-backend"
  }
}
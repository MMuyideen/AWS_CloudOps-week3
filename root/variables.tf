variable "region" {
  description = "The AWS region where our resources will be deployed"
}

variable "project_name" {
  description = "The name of our project, also prefix for naming conventions"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
}

variable "pub_sub_1a_cidr" {
  description = "CIDR for the NAT gateway subnet in AZ1"
}

variable "pub_sub_2b_cidr" {
  description = "CIDR for the NAT gateway subnet in AZ1"
}

variable "pri_sub_3a_cidr" {
  description = "CIDR for the web server subnet in AZ1"
}

variable "pri_sub_4b_cidr" {
    description = "CIDR for the web server subnet in AZ2"
}

variable "pri_sub_5a_cidr" {
    description = "CIDR for the database subnet in AZ1"
}

variable "pri_sub_6b_cidr" {
    description = "CIDR for the database subnet in AZ1"
}

variable "db_username" {
  description = "username for the database"
}

variable "db_password" {
  description = "password for the database"
}

variable "certificate_domain_name" {
    description = "root doamin url"
}

variable "additional_domain_name" {
    description = "subdomain for custom domain"
}
variable "region" {
  description = "The region where AWS operations will take place"
  default     = "eu-central-1"
  type        = "string"
}

//variable "vpc_name" {
//  description = "The name of AWS VPC"
//  default     = "terraform-aws-vpc-test-2"
//  type        = "string"
//}

variable "environment" {
  description = "The name of the deployment environment."
  default     = "dev"
  type        = "string"
}

variable "alias_name" {
  description = "The name of the key alias"
  type        = "string"
  default     = "digitoll/encr/decr"
}

variable "deletion_window_in_days" {
  description = "The duration in days after which the key is deleted after destruction of the resource"
  type        = "string"
  default     = 30
}

variable "key_policy" {
  description = "The policy of the key usage"
  type        = "string"
  default     = ""
}

//variable "existing_vpc_name" {
//  description = "The name of existing VPC"
//  type        = "string"
//  default     = "terraform-aws-vpc-test-2"
//}

//variable "AmiLinux" {
//  type = "string"
//  eu-central-1 = "ami-0f6cc777a107c31e9" # AMI dev2
//  description = "AMI dev2"
//}
/*
variable "aws_access_key" {
  default = "xxxxx"
  description = "the user aws access key"
}

variable "aws_secret_key" {
  default = "xxxx"
  description = "the user aws secret key"
}
*/

//variable "credentialsfile" {
//  default = "/home/sysadmin/.aws/credentials" #replace your home directory
//  description = "where access and secret_key are stored, the file is created when run the aws config"
//}

//variable subscription_id {}
//variable client_id {}
//variable client_secret {}
//variable tenant_id {}
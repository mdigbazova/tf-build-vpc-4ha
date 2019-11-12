provider "aws" {
  region              = "${var.region}"
  //version             = "~> 2.34"
  allowed_account_ids = [
    "070710213444",
    "393305049144"
  ]
}

# ------------------------------------------------------------------------------
# CREATE THE VPC ITSELF
# ------------------------------------------------------------------------------

resource "aws_vpc" "environment-test-3" {
  //cidr_block           = "10.0.0.0/16"
  cidr_block           = "172.31.0.0/16"
  //instance_tenancy     = "dedicated"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "terraform-aws-vpc-test-3"
  }
}


# ------------------------------------------------------------------------------
# CREATE THE VPC SUBNETS
# ------------------------------------------------------------------------------

// if we like only to add other resources to an existing VPC:
resource "aws_subnet" "subnet-3-1" {
  vpc_id            = aws_vpc.environment-test-3.id
  cidr_block        = cidrsubnet(aws_vpc.environment-test-3.cidr_block, 3, 1)
  availability_zone = "eu-central-1a"
  tags = {
    Name = "dev-3-eu-central-1a"
  }
}

resource "aws_subnet" "subnet-3-2" {
  vpc_id            = aws_vpc.environment-test-3.id
  cidr_block        = cidrsubnet(aws_vpc.environment-test-3.cidr_block, 2, 2)
  availability_zone = "eu-central-1b"
  tags = {
    Name = "dev-3-eu-central-1b"
  }
}


# ------------------------------------------------------------------------------
# CREATE THE VPC SECURITY GROUP
# ------------------------------------------------------------------------------

resource "aws_security_group" "subnetsecurity" {
  vpc_id = aws_vpc.environment-test-3.id

  ingress {
    cidr_blocks = [
      aws_vpc.environment-test-3.cidr_block
    ]

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
}


# ------------------------------------------------------------------------------
# Locals
# ------------------------------------------------------------------------------

locals {
  tags = {
    SYSTEM                = "DigiToll"
    OWNER                 = "HyperAspect"
    //ENV_NAME              = "${var.environment}"
    DESCRIPTION           = "VPC creation"
    MANAGED_BY            = "Terraform"
  }
}


# ------------------------------------------------------------------------------
# CREATE THE S3 BUCKET
# ------------------------------------------------------------------------------
//// commented as I don't know whether it is needed:
//resource "aws_s3_bucket" "mery_terraform_state" {
//  bucket = "mery-test-terraform-state"
//
//  # Enable versioning so we can see the full revision history of our
//  # state files
//  versioning {
//    enabled = true
//  }
//
//  # Enable server-side encryption by default
//  server_side_encryption_configuration {
//    rule {
//      apply_server_side_encryption_by_default {
//        sse_algorithm = "AES256"
//      }
//    }
//  }
//}


//terraform {
//  backend "s3" {
//    bucket          = "mery-test-terraform-state"
//    key             = "digitoll/encr/decr"
//    region          = "${var.region}"
//    encrypt         = "true"
//  }
//}


resource "aws_kms_key" "key" {
  key_usage               = "ENCRYPT_DECRYPT"
  #policy                  = "${data.aws_iam_policy_document.cmk_key_policy.json}"
  policy                  = "${var.key_policy}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  is_enabled              = true
  enable_key_rotation     = true
  tags                    = "${local.tags}"
}

resource "aws_kms_alias" "key_alias" {
  name                    = "alias/${var.alias_name}"
  target_key_id           = "${aws_kms_key.key.id}"
}



//---------
// if we like to create a new VPC and add additional resources
//resource "aws_vpc" "environment-test-1" {
//  //cidr_block           = "10.0.0.0/16"
//  cidr_block           = "172.31.0.0/16"
//  enable_dns_hostnames = true
//  enable_dns_support   = true
//  tags = {
//    Name = "terraform-aws-vpc-test-1"
//  }
//}
//
//resource "aws_subnet" "subnet1" {
//  cidr_block = cidrsubnet(aws_vpc.environment-test-1.cidr_block, 3, 1)
//  vpc_id = aws_vpc.environment-test-1.id
//  availability_zone = "us-west-2a"
//}
//
//resource "aws_subnet" "subnet2" {
//  cidr_block = cidrsubnet(aws_vpc.environment-test-1.cidr_block, 2, 2)
//  vpc_id = aws_vpc.environment-test-1.id
//  availability_zone = "us-west-2b"
//}
//
//resource "aws_security_group" "subnetsecurity" {
//  vpc_id = aws_vpc.environment-test-1.id
//
//  ingress {
//  cidr_blocks = [
//    aws_vpc.environment-test-1.cidr_block
//  ]
//
//    from_port = 80
//    to_port = 80
//    protocol = "tcp"
//  }
//}
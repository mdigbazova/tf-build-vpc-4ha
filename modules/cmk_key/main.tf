provider "aws" {
  region  = "${var.region}"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cmk_key_policy" {
  statement {
    sid = "Enable IAM User Permissions"

    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }
}


locals {
  tags = {
    SYSTEM                = "DigiToll"
    OWNER                 = "HyperAspect"
    ENV_NAME              = "${var.environment}"
    DESCRIPTION           = "Key to encrypt and decrypt secret parameters in the project DigiToll"
    MANAGED_BY            = "Terraform"
  }
}

resource "aws_kms_key" "key" {
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = "${data.aws_iam_policy_document.cmk_key_policy.json}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  #is_enabled              = true
  enable_key_rotation     = true
  tags                    = "${local.tags}"
}

resource "aws_kms_alias" "key_alias" {
  name                    = "alias/${var.alias_name}"
  target_key_id           = "${aws_kms_key.key.id}"
}




//resource "aws_regions" "region" {
//  # Create one request for each given available regions.
//  count = length(var.available_regions)
//
//  # Use one of the specified available regions.
//  region = var.available_regions[count.index]
//
//  # By referencing the aws_vpc.main object, Terraform knows that the subnet
//  # must be created only after the VPC is created.
//  #vpc_id = aws_vpc.main.id
//
//  # Built-in functions and operators can be used for simple transformations of
//  # values, such as computing a subnet address. Here we create a /20 prefix for
//  # each subnet, using consecutive addresses for each availability zone,
//  # such as 10.1.16.0/20 .
//  #cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index+1)
//}

//
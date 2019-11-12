provider "aws" {
  region  = "${var.region}"
}

data "aws_iam_policy_document" "lambda-role-policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

//locals {
//  tags = {
//    SYSTEM = "DigiToll"
//    OWNER = "Mery"
//    //ENV_NAME = "${var.environment}"
//  }
//}

//resource "aws_iam_role_policy_attachment" "lambda-basic-execution" {
//  role = "${aws_iam_role.lambda.id}"
//  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
//}
//
//resource "aws_iam_role_policy_attachment" "lambda-kinesis-execution" {
//  role = "${aws_iam_role.lambda.id}"
//  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaKinesisExecutionRole"
//}
//
//resource "aws_iam_role" "lambda" {
//  assume_role_policy = "${data.aws_iam_policy_document.lambda-role-policy.json}"
//  tags = "${local.tags}"
//}
//
//resource "aws_lambda_event_source_mapping" "data-source" {
//  event_source_arn = "${var.kinesis-stream-arn}"
//  function_name = "${aws_lambda_function.event-adapter.arn}"
//  starting_position = "${var.kinesis-stream-starting-position}"
//  batch_size = "${var.lambda-function-batch-size}"
//  enabled = "${var.lambda-kinesis-enabled}"
//}
//
//resource "aws_lambda_function" "event-adapter" {
//  filename = "${var.lambda-payload-filename}"
//  function_name = "${var.lambda-function-name}"
//  description = "${var.lambda-function-description}"
//  role = "${aws_iam_role.lambda.arn}"
//  handler = "${var.lambda-function-handler-class}"
//  runtime = "java8"
//  source_code_hash = "${base64sha256(file(var.lambda-payload-filename))}"
//  tags = "${local.tags}"
//}

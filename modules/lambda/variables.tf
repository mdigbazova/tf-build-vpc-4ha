variable "environment" {
  type = "string"
  description = "The name of the deployment environment."
}

variable "kinesis-stream-arn" {
  type = "string"
  description = "The ARN of the Kinesis stream that represents the source of the events."
}

variable "kinesis-stream-starting-position" {
  type = "string"
  description = "The starting position from which to consume from the Kinesis Stream."
  default = "LATEST"
}

variable "lambda-payload-filename" {
  type = "string"
  description = "The path to the payload file for the AWS Lambda."
}

variable "lambda-function-handler-class" {
  type = "string"
  description = "The FQN of the Java class that implements the Lambda function handler."
}

variable "lambda-function-name" {
  type = "string"
  description = "The human-readable name of the Lambda function."
}

variable "lambda-function-batch-size" {
  type = "string"
  description = "The largest number of records the Lambda will receive for processing."
  default = "100"
}

variable "lambda-function-description" {
  type = "string"
  description = "The human readable description of the adapter."
  default = ""
}

variable "lambda-kinesis-enabled" {
  type = "string"
  description = "Whether the mapping between the Kinesis stream and the Lambda function is enabled. If disabled no events will flow to the Lambda function."
  default = "true"
}

variable "region" {
  description = "The region where AWS operations will take place"
  type        = "string"
}

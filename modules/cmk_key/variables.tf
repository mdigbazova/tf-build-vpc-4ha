variable "environment" {
  description = "The name of the deployment environment."
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
}

variable "region" {
  description = "The region where AWS operations will take place"
  type        = "string"
}








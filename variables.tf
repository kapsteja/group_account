variable "region" {
  description = "AWS region to use."
  type        = string
  default     = "us-east-1"
}

variable "identity_store_id" {
  description = "The AWS Identity Store ID."
  type        = string
}

variable "group_name" {
  description = "The display name of the existing group (synced from Azure AD)."
  type        = string
}

variable "permission_set_name" {
  description = "The admin permission set name attached to the group."
  type        = string
}

variable "aws_account_ids" {
  description = "List of AWS Account IDs to assign admin access via the group."
  type        = list(string)
}

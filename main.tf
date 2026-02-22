##############################################
# Data Sources - Fetch existing SSO resources
# Users & group memberships are synced from
# AD via SCIM - DO NOT manage in Terraform
##############################################

data "aws_ssoadmin_instances" "this" {}

# Fetch the existing group by display name (synced from AD)

data "aws_identitystore_group" "this" {
  identity_store_id = var.identity_store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = var.group_name
    }
  }
}

# Fetch the admin permission set by name
data "aws_ssoadmin_permission_set" "admin" {
  instance_arn = data.aws_ssoadmin_instances.this.arns[0]
  name         = var.permission_set_name
}

##############################################
# Resources - Managed by Terraform
# To give admin access to an account, add the
# account ID to aws_account_ids in terraform.tfvars
##############################################

# Account assignments: attach admin permission set to the group per account
resource "aws_ssoadmin_account_assignment" "group_assignments" {
  for_each           = toset(var.aws_account_ids)
  instance_arn       = data.aws_ssoadmin_instances.this.arns[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.admin.arn
  principal_id       = data.aws_identitystore_group.this.group_id
  principal_type     = "GROUP"
  target_id          = each.value
  target_type        = "AWS_ACCOUNT"
}

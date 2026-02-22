region            = "us-east-1"
identity_store_id = "d-xxxxxxxxxx"

# Group name (synced from  AD - users & memberships managed by AD)
group_name = "YourGroupName"

# Admin permission set attached to the group
permission_set_name = "AdministratorAccess"

# AWS Account IDs to give admin access via this group
# To grant admin access to a new account, add its ID here and run terraform apply
aws_account_ids = [
  "111111111111",
  "222222222222",
  "333333333333",
]

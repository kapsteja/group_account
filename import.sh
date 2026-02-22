#!/bin/bash

###############################################
# Import existing account assignments into
# Terraform state.
#
# One group + one admin permission set assigned
# to multiple AWS accounts.
###############################################

# Set your IDs here
GROUP_ID="group-abcdefg"
INSTANCE_ARN="arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx"
PERMISSION_SET_ARN="arn:aws:sso:::permissionSet/ssoins-xxxxxxxxxxxxxxx/ps-admin"

# AWS Account IDs that already have the admin assignment
ACCOUNT_IDS=(
  "111111111111"
  "222222222222"
  "333333333333"
)

echo "=== Importing account assignments ==="
for ACCOUNT_ID in "${ACCOUNT_IDS[@]}"; do
  echo "Importing assignment for account $ACCOUNT_ID..."
  terraform import "aws_ssoadmin_account_assignment.group_assignments[\"$ACCOUNT_ID\"]" \
    "${PERMISSION_SET_ARN},${GROUP_ID},GROUP,${ACCOUNT_ID},AWS_ACCOUNT,${INSTANCE_ARN}"
done

echo ""
echo "=== Import complete. Run 'terraform plan' to verify ==="

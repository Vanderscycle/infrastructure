resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com"
  ]

  feature_set = "ALL"
}


resource "aws_organizations_organizational_unit" "non-prod" {
  name      = "non-prod"
  parent_id = aws_organizations_organization.org.roots[0].id
}


resource "aws_organizations_account" "non-prod" {
  # A friendly name for the member account
  name  = "non-prod"
  email = "aws-non-prod@proton.me"

  # Enables IAM users to access account billing information
  # if they have the required permissions
  iam_user_access_to_billing = "ALLOW"

  tags = {
    Name  = "non-prod"
    Owner = "hvandersleyen"
    Role  = "development"
  }

  parent_id = aws_organizations_organizational_unit.non-prod.id
}

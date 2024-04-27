resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "admin_policy"
  group = aws_iam_group.administrator.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = [
              "471112966897",
            ]
          }
        }
      },
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# admin group
resource "aws_iam_group" "administrator" {
  name = "administrators"
  path = "/admin/"
}

resource "aws_iam_group_membership" "administrator_membership" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.administrator.name,
  ]

  group = aws_iam_group.administrator.name
}
# admin user

resource "aws_iam_user" "administrator" {
  name = "administrator"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "administrator_key" {
  user = aws_iam_user.administrator.name

  lifecycle {
    prevent_destroy = true
  }
}



#
# OUTPUT
#
resource "aws_ssm_parameter" "output" {
  name = "/user/${aws_iam_user.administrator.name}"
  type = "SecureString"
  value = jsonencode({
    key    = aws_iam_access_key.administrator_key.id
    secret = aws_iam_access_key.administrator_key.secre
  })
}

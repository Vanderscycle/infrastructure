
locals {
  name      = "github-oidc"
  oidc_host = "token.actions.githubusercontent.com"

  # retrieve the SSL certificate from the host
  # echo | openssl s_client -showcerts -connect token.actions.githubusercontent.com:443 </dev/null 2>/dev/null | openssl x509 -outform PEM > github_actions.pem
  # calculate the SHA-1 thumbprint
  # openssl x509 -in github_actions.pem -fingerprint -noout | sed 's/SHA1 Fingerprint=//g' | sed 's/://g' | tr '[:upper:]' '[:lower:]'

  github_oidc_thumbprint = [
    "1b511abead59c6ce207077c0bf0e0043b1382612"
  ]

  github_repo_list = [for s in local.github_repositories : format("repo:Vanderscycle/%s:*", s)]
  github_repositories = [
    "BallOfNoodsWebsite"
  ]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${var.AWS_account_id}:oidc-provider/${local.oidc_host}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${local.oidc_host}:sub" : local.github_repo_list
          },
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com",
          }
        }
      }
    ]
  })

}

#
# IAM POLICIES
#
resource "aws_iam_policy" "this" {
  name = "${local.name}-iam-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:PutImage",
          "s3:PutObject",
          "s3:GetObject"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Secrets",
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameter*",
          "secretsmanager:GetSecretValue"
        ],
        "Resource" : "*"
      }
    ]
  })
}

#
# GITHUB ROLE
#
resource "aws_iam_role" "this" {
  name               = "${local.name}-iam-role"
  assume_role_policy = local.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

#
# GITHUB USER
#
resource "aws_iam_user" "gh_user" {
  name = "${local.name}-iam-user"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "gh_user_key" {
  user = aws_iam_user.gh_user.name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.gh_user.name
  policy_arn = aws_iam_policy.this.arn
}

#
# OIDC
#
resource "aws_iam_openid_connect_provider" "this" {
  url = "https://${local.oidc_host}"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = local.github_oidc_thumbprint
}

#
# OUTPUT
#
resource "aws_ssm_parameter" "output" {
  name = "/github/${aws_iam_user.gh_user.name}"
  type = "SecureString"
  value = jsonencode({
    key    = aws_iam_access_key.gh_user_key.id
    secret = aws_iam_access_key.gh_user_key.secret
  })
}

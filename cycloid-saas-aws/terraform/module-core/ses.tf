data "aws_iam_policy_document" "ses" {
  statement {
    actions = [
      "ses:ListIdentities",
      "ses:SendEmail",
      "ses:SendRawEmail",
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ses" {
  name        = "${var.project}-${var.env}-ses_access"
  description = "Grant ses access"
  policy      = data.aws_iam_policy_document.ses.json
}

resource "aws_iam_user" "ses" {
  name = "ses-${var.project}-${var.env}"
  path = "/"
}

resource "aws_iam_access_key" "ses" {
  user = aws_iam_user.ses.name
}

resource "aws_iam_user_policy_attachment" "ses_access" {
  user       = aws_iam_user.ses.name
  policy_arn = aws_iam_policy.ses.arn
}

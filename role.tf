## Iam Role

resource "aws_iam_role" "cluster-role" {
  name = "${var.cluster_role_name}-${data.aws_caller_identity.account.account_id}-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}
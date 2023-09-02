resource "aws_iam_policy" "user-policy" {
  count  = fileexists("policy.json") ? 1 : 0
  name   = "${var.cluster_name}-${data.aws_caller_identity.account.account_id}-${var.env}-eks-cluster-userbased-nodegroup-k8s-policy"
  policy = var.iam_policy
}

resource "aws_iam_policy" "user-policy" {
  count  = fileexists("policy.json") ? 1 : 0
  name   = "${var.CLUSTER_NAME}-${var.ENV}-${var.AIRPORT_CODE[var.AWS_REGION]}-eks-cluster-userbased-nodegroup-${var.NODE_GROUP_NAME}-k8s-policy"
  policy = var.IAM_POLICY
}

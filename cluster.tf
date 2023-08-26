## EKS Custer module

## aws get sts-caller-idenity --> aws account number 

data "aws_subnets" "subnets" {
  filter {
    name   = "tag:Name"
    values = var.subnet_names
  }
}

data "aws_subnet" "id" {
  for_each = toset(data.aws_subnets.subnets.ids) ## 2 times
  id       = each.value
}

resource "aws_eks_cluster" "cluster" {
  name     = "${var.cluster_name}-${data.aws_caller_identity.account.account_id}-${var.env}"
  role_arn = aws_iam_role.cluster-role.arn
  vpc_config {
    subnet_ids              = [for s in data.aws_subnet.id : s.id]
    security_group_ids      = []
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  encryption_config {
  provider {
      key_arn =  aws_kms_key.key.arn
      }
  resources =  ["secrets"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy-attachment,
    aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy-attachment
  ]
}
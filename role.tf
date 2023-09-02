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

### EKS Managed Node group role
resource "aws_iam_role" "worker-node-role" {
  name = "${var.node_group_name}-${data.aws_caller_identity.account.account_id}-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

### Node group policy
## Policy attachement for Worker nodes
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker-node-role.name
}

## Pre-defined Policy attachment for nodegroups
resource "aws_iam_role_policy_attachment" "nodegroup-policy-attachment" {
  role       = aws_iam_role.worker-node-role.name
  policy_arn = aws_iam_policy.k8s_policy.arn
}

resource "aws_iam_role_policy_attachment" "userpolicy" {
  count      = fileexists("policy.json") ? 1 : 0
  role       = aws_iam_role.worker-node-role.name
  policy_arn = aws_iam_policy.user-policy[count.index].arn
}
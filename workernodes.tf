
resource "aws_eks_node_group" "worker_node" {
  cluster_name    = "${var.cluster_name}-${data.aws_caller_identity.account.account_id}-${var.env}"
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.worker-node-role.arn
  subnet_ids      = [for s in data.aws_subnet.id : s.id]
  instance_types  = var.instance_types
  disk_size       = var.disk_size
  ami_type        = var.ami_type
  capacity_type   = var.capacity_type
  release_version = var.ami_version

  tags = var.tags

  labels = var.labels


  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.cluster
  ]

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

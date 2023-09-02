##Policy attachment for K8s Cluster (Control Plane)
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy-attachment" {
  role       = aws_iam_role.cluster-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSServicePolicy-attachment" {
  role       = aws_iam_role.cluster-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

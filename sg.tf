## Security Groups
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values =  var.vpc_name
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster_name}-${data.aws_caller_identity.account.account_id}-${var.env}-sg"
  description = "Allow TLS inbound outbund traffic"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  for_each          = local.ports
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_ipv4         = each.value
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
}

resource "aws_security_group_rule" "cluster-egress-all" {
  description       = "Allow cluster egress access to the internet"
  security_group_id = aws_security_group.eks_cluster_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1

  cidr_blocks = [
    "0.0.0.0/0"
  ]
}


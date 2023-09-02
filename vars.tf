## variables

variable "cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}

variable "node_group_name" {
  type        = string
  description = "EKS Managed node group name"
}

variable "cluster_role_name" {
  type        = string
  description = "EKS Cluster Role Name"
}

variable "vpc_name" {
  type = list(any)
}

variable "subnet_names" {
  type = list(any)
}

variable "env" {
  type    = string
  default = "dev"
}

variable "tags" {
  type = map(string)
}

variable "labels" {
  type = map(string)
  default = {
    app = "demo"
  }
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "disk_size" {
  type    = number
  default = 8
}

variable "ami_type" {
  default = null
}

variable "capacity_type" {
  default = null
}

variable "ami_version" {
  default = null
}

variable "desired_size" {
  default = 1
  type    = number
}

variable "max_size" {
  default = 2
  type    = number
}

variable "min_size" {
  default = 1
  type    = number
}

variable "iam_policy" {
  default = null
}


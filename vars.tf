## variables

variable "cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}

variable "cluster_role_name" {
  type        = string
  description = "EKS Cluster Role Name"
}

variable "vpc_name" {
    type = list
}

variable "subnet_names"{
    type = list
}

variable "env" {
  type    = string
  default = "dev"
}

variable "tags" {
  type = map(string)
}
## Shared block

data "aws_caller_identity" "account" {}

locals {
  ports = {
    22  = "10.0.0.0/16"
    443 = "10.0.0.0/16"
    80  = "10.0.0.0/16"
  }
}
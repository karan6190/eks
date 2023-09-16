## EKS

This Repo creates the EKS Cluster using terraform 

#### Prerequisite
> Tools or Access required

1- AWS Account

2- Terraform 


#### Code Structure
```bash
|--modules ## contains the terraform module
  |--k8s-cluster
  |--k8s-nodegroup
|--provisioning
  |--dev
    |--cluster

```

#### Terraform commands for provisioning
```hcl
cd provisioning/dev/cluster/kc1

terraform init -backend-config="bucket=<ENTER_YOUR_BUCKET_NAME>" -backend-config="key=<ENTER_YOUR_BUCKET_NAME>/terraform.tfstate" -backend-config="region=<ENTER_YOUR_AWS_REGION>"

terraform plan

terraform apply

```

#### Cluster Provisioning | Terraform module 

*Fields* | *Example Values* | *Description* | *Required* |
---| --- | --- | -- |
ENV | dev/prod | Type of Environment | yes |
PRODUCT_NAME | demo | Cluster prefix | yes
CLUSTER_ALAIAS | kc1 | K8s cluster alias | yes |
CLUSTER_VERSION | 1.25 | EKS Cluster Version | yes |
AWS_REGION | us-east-1 | AWS Region  | yes |
VPC_NAME | Default | AWS VPC NAME | yes |
SUBNETS_NAMES | ["Public-subnet-1", "Public-subnet-2", "Public-subnet-3"] | AWS Subnets name where to launch the EKS Cluster | yes |
PUBLIC_ENDPOINT_ACCESS | true/false | Enable Public endpoint access, Default is True | No |
PRIVATE_ENDPOINT_ACCESS | true/false | Enable Public endpoint access, Default is False | No |


### NodeGroup Provisioning | Terraform module

*Fields* | *Example Values* | *Description* | *Required* |
---| --- | --- | -- |
ENV | dev/prod | Type of Environment | yes |
PRODUCT_NAME | demo | Cluster prefix to which nodegroup need to be attached | yes
CLUSTER_ALAIAS | kc1 | K8s cluster alias | yes |
NODE_GROUP_NAME | infra | Worker node name | yes |
INSTANCE_TYPE | [t3.medium] | Type of Instances | yes |
AMI_TYPE | AL2_x86_64 | AMI Type| yes |
AWS_REGION | us-east-2 | AWS Region  | yes |
CAPACITY_TYPE | ON_Demand | Type of Instances required like RESERVED or ON DEMAND | yes |
DISK_SIZE | 30 | EBS Volume | yes|
DESIRED_INSTANCE | 1 | Desired number of instances | yes |
MAX_INSTANCE | 2 | Max number of instance in case of aut-scale | yes |
MIN_INSTANCE | 1 | Min number of instances | yes|
ENV | dev | Env type | yes |
SUBNETS_NAMES | ["Public-subnet-1", "Public-subnet-2", "Public-subnet-3"] | AWS Subnets name where to launch the work nodes | yes |
MANAGED_POLICY | arn:aws:iam:** | AWS managed policy needs to be attached to worker node | yes |
IAM_POLICY | [policy.json](provisioning/dev/cluster/policy.json) | yes |
labels | stack=infra | labeling the worker node | yes |

> Once provisioned successfully - aws eks update-kubeconfig --name <Cluster_Name> --region <AWS_REGION> --profile <AWSCLI_PROFILE_NAME>

#### TO-DO

* Fargate-profile


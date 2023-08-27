# EKS
> Provisioning eks cluster

The Following helps in provisioning EKS cluster.

* Inputs needed to provisoning the cluster inside your account vpc
    * Update [terraform.tfvars](./terraform.tfvars) as per your requirements


####
git clone -b main https://github.com/mehoussou/eks.git
ls
cd eks
git checkout -b emc/branch
git add .
git commit -m "initial commit"
git push -u origin emc/branch
git push
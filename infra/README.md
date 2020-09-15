# Provision AWS resources
AWS resources to build infrastructure for app deployment.

## IAM user/policy
Creates,
- An IAM user with permissions to push app image to the registry.
- A polcy to give worker node role permission on ALB configuration.

## ECR registry
Creates Elastic Container registry to upload the app image.

## EKS Cluster
Creates,
- VPC, public/private subnets, security groups.
- K8s cluster on AWS with Elastic Kubernetes Service.

After installing the AWS CLI. Configure it with credentials.

```shell
$ aws configure --profile personal
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <default_region>
Default output format [None]: json
```

This enables Terraform access to the configuration file and perform operations with these security credentials.
Initalize Terraform workspace with below commands, which will download the provider/modules and initialize it with the values provided in the `terraform.tfvars` file.

```shell
$ terraform workspace new infra
$ terraform init
```

Provision EKS cluster by running `terraform apply`. This can take about 10 minutes.

```shell
$ terraform apply
```

### Configure kubectl

To configure kubetcl, both [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is needed.

The following command will get the access credentials for the cluster and automatically configure `kubectl`.

```shell
$ aws eks --region <region_of_eks> update-kubeconfig --name <name_of_cluster>
```
Kubernetes cluster name and region correspond to the output variables showed after the successful Terraform run. Outputs can be again viewed by running:

```shell
$ terraform output
```
### Install ingress controller

ALB is the ingress controller installed

```shell
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install alb-ingress incubator/aws-alb-ingress-controller --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true --set clusterName=<eks_cluster_name>
```

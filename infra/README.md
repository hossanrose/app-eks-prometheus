# Provision AWS resources
AWS resources to build a production grade infrastructure for app deployment

## IAM user
Creates an IAM user with permissions to push app image to the registry.

## ECR registry
Creates Elastic Container registry to upload the app image.

## EKS Cluster
Creates K8s cluster on AWS with Elastic Kubernetes Service

After installing the AWS CLI. Configure it to use your credentials.

```shell
$ aws configure --profile personal
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <default_region>
Default output format [None]: json
```

This enables Terraform access to the configuration file and performs operations on your behalf with these security credentials.

After you've done this, initalize your Terraform workspace, which will download the provider and initialize it with the values provided in the `terraform.tfvars` file.

```shell
$ terraform workspace new infra
$ terraform init
```

Then, provision your EKS cluster by running `terraform apply`. 
This will take approximately 10 minutes.

```shell
$ terraform apply
```

### Configure kubectl

To configure kubetcl, you need both [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

The following command will get the access credentials for your cluster and automatically
configure `kubectl`.

```shell
$ aws eks --region <region_of_eks> update-kubeconfig --name <name_of_cluster>
```
Kubernetes cluster name and region correspond to the output variables showed after the successful Terraform run. You can view these outputs again by running:

```shell
$ terraform output
```
### Install ingress controller

ALB is the ingress controller installed

```shell
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install incubator/aws-alb-ingress-controller --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true --set clusterName=<eks_cluster_name>
```

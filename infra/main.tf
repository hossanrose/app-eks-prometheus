## Setting up the VPC 
data "aws_availability_zones" "available" {}

locals {
  cluster_name = "eks-cluster${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.vpc_private_subnet
  public_subnets       = var.vpc_public_subnet
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

## Setting up the EKS cluster
module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Environment = "EKS"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                 = var.eks_worker_group
      instance_type        = var.eks_worker_type
      asg_desired_capacity = var.eks_worker_capacity
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
  ]
}

## Security group for worker
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

  ingress {
    description = "Health check"
    from_port   = 10254
    to_port     = 10254
    protocol    = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

}

## Backend state configuration
terraform {
  backend "s3" {
    bucket = "app-infra-terraform"
    key    = "infra"
    region = "eu-west-1"
  }
}

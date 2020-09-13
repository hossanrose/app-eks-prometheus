region             = "us-west-2"
vpc_name           = "eks-vpc"
vpc_cidr           = "10.1.0.0/16"
vpc_private_subnet = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
vpc_public_subnet  = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
eks_worker_group   = "worker-group"
eks_worker_type    = "t2.small"


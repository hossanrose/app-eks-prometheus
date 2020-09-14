variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR range"
  type        = string
}

variable "vpc_public_subnet" {
  description = "Public subnets"
  type        = list(string)
}

variable "vpc_private_subnet" {
  description = "Private subnets"
  type        = list(string)
}

variable "eks_worker_group" {
  description = "EKS worker group name"
  type        = string
}

variable "eks_worker_type" {
  description = "EKS worker type"
  type        = string
}

variable "eks_worker_capacity" {
  description = "EKS worker capacity"
  type        = string
}

provider "aws" {
  version = ">= 2.28.1"
  region  = "us-west-2"
  profile = "personal"
}

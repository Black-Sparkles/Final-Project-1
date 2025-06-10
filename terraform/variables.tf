variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_az1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_az2" {
  default = "10.0.2.0/24"
}

variable "cluster_name" {
  default = "cluster.k8s.local"
}


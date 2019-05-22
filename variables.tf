variable "product_domain_name" {
  description = "Name of product domain (e.g. maps)"
}

variable "environment_type" {
  description = "Type of environment (e.g. test, int, e2e, prod)"
}

variable "operations_aws_account_number" {
  description = "AWS operation account number (without hyphens)"
}

variable "vpc_id" {
  description = "ID of existing VPC where cluster will be deployed"
}

variable "region" {
  description = "AWS region"
}

variable "azs" {
  description = "Availability Zones for the cluster (1 master per AZ will be deployed)"
  type        = "list"
}

variable "k8s_private_subnets" {
  description = "List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used)"
  type        = "list"
}

variable "k8s_node_count" {
  description = "Number of worker nodes in Kubernetes cluster"
  default     = "3"
}

variable "k8s_master_instance_type" {
  description = "Instance type (size) for master nodes"
  default     = "m4.large"
}

variable "k8s_node_instance_type" {
  description = "Instance type (size) for worker nodes"
  default     = "m4.large"
}

variable "k8s_masters_iam_policies_arns" {
  description = "(Optional) List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances)"
  type        = "list"
  default     = []
}

variable "k8s_nodes_iam_policies_arns" {
  description = "(Optional) List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances)"
  type        = "list"
  default     = []
}

variable "k8s_linux_distro" {
  description = "Linux distribution for K8s cluster instances (supported values: debian, amzn2)"
  default     = "debian"
}

variable "http_proxy" {
  description = "IP[:PORT] - address and optional port of HTTP proxy to be used to download packages"
}

variable "k8s_aws_ssh_keypair_name" {
  description = "Optional name of existing SSH keypair on AWS account, to be used for cluster instances (will be generated if not specified)"
  default     = ""
}

variable "no_proxy" {
  description = "Comma seperated list of urls to be excluded from proxying."
  default     = ""
}

variable "k8s_enable_pod_autoscaling" {
  description = "Enable horizontal pod autoscaling"
  default     = false
}

variable "k8s_enable_cluster_autoscaling" {
  description = "Enable cluster autoscaling"
  default     = false
}

variable "k8s_protect_cluster_from_scale_in" {
  description = "Protect cluster nodes from scale in (if using cluster autoscaling)"
  default     = false
}

variable "k8s_install_helm" {
  description = "Install Helm during the deployment of the cluster"
  default     = true
}

variable "k8s_allowed_worker_ssh_cidrs" {
  type        = "list"
  description = "List of CIDR ranges to allow SSH access into worker nodes"
  default     = []
}

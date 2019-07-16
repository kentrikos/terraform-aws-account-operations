# A Terraform module to create "operations" type of environment.

This module will create an environment suitable for "operations" type of AWS account.
Most important elements of the environment:

* VPC (not created by this module, must exist apriori as it can be only created with a portal)
* Kubernetes cluster (to be used for CI/CD, monitoring, etc.)
* ECR Docker registry

# Notes

Terraform version  `>= 0.12`

## Usage

```hcl
module "operations" {
  source = "github.com/kentrikos/terraform-aws-account-operations"

  product_domain_name              = "${var.product_domain_name}"
  environment_type                 = "${var.environment_type}"

  region                           = "${var.region}"
  azs                              = "${var.azs}"
  vpc_id                           = "${var.vpc_id}"
  k8s_private_subnets              = "${var.k8s_private_subnets}"
  http_proxy                       = "${var.http_proxy}"
  no_proxy                         = "${var.no_proxy}"

  k8s_node_count                   = "${var.k8s_node_count}"
  k8s_master_instance_type         = "${var.k8s_master_instance_type}"
  k8s_node_instance_type           = "${var.k8s_node_instance_type}"

  k8s_masters_iam_policies_arns    = "${var.k8s_masters_iam_policies_arns}"
  k8s_nodes_iam_policies_arns      = "${var.k8s_nodes_iam_policies_arns}"
  
  map_roles            = "${var.k8s_map_roles}"
  map_users            = "${var.k8s_map_users}"
  map_accounts         = "${var.k8s_map_accounts}"
  enable_default_roles = "${var.enable_default_roles}"
  
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `azs` | Availability Zones for the cluster (1 master per AZ will be deployed) | list(string) | n/a |  yes |
| `enable_default_roles` | Enable creation of default roles to assume | n/a | `true` |  no |
| `environment_type` | Type of environment (e.g. test, int, e2e, prod) | n/a | n/a |  yes |
| `http_proxy` | IP[:PORT] - address and optional port of HTTP proxy to be used to download packages | n/a | n/a |  yes |
| `k8s_allowed_worker_ssh_cidrs` | List of CIDR ranges to allow SSH access into worker nodes | list(string) | n/a |  yes |
| `k8s_aws_ssh_keypair_name` | Optional name of existing SSH keypair on AWS account, to be used for cluster instances (will be generated if not specified) | n/a | n/a |  yes |
| `k8s_enable_cluster_autoscaling` | Enable cluster autoscaling | n/a | n/a |  yes |
| `k8s_enable_pod_autoscaling` | Enable horizontal pod autoscaling | n/a | n/a |  yes |
| `k8s_install_helm` | Install Helm during the deployment of the cluster | n/a | `true` |  no |
| `k8s_linux_distro` | Linux distribution for K8s cluster instances (supported values: debian, amzn2) | n/a | `"debian"` |  no |
| `k8s_master_instance_type` | Instance type (size) for master nodes | n/a | `"m4.large"` |  no |
| `k8s_masters_iam_policies_arns` | (Optional) List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances) | list(string) | n/a |  yes |
| `k8s_node_count` | Number of worker nodes in Kubernetes cluster | n/a | `"3"` |  no |
| `k8s_node_instance_type` | Instance type (size) for worker nodes | n/a | `"m4.large"` |  no |
| `k8s_nodes_iam_policies_arns` | (Optional) List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances) | list(string) | n/a |  yes |
| `k8s_private_subnets` | List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used) | list(string) | n/a |  yes |
| `k8s_protect_cluster_from_scale_in` | Protect cluster nodes from scale in (if using cluster autoscaling) | n/a | n/a |  yes |
| `map_accounts` | Additional AWS account numbers to add to the aws-auth configmap. See terraform-aws-modules-eks examples/basic/variables.tf for example format. | list(string) | n/a |  yes |
| `map_roles` | Additional IAM roles to add to the aws-auth configmap. See terraform-aws-modules-eks examples/basic/variables.tf for example format. | list(map(string)) | n/a |  yes |
| `map_users` | Additional IAM users to add to the aws-auth configmap. See terraform-aws-modules-eksexamples/basic/variables.tf for example format. | list(map(string)) | n/a |  yes |
| `no_proxy` | Comma seperated list of urls to be excluded from proxying. | n/a | n/a |  yes |
| `operations_aws_account_number` | AWS operation account number (without hyphens) | n/a | n/a |  yes |
| `product_domain_name` | Name of product domain (e.g. maps) | n/a | n/a |  yes |
| `region` | AWS region | n/a | n/a |  yes |
| `vpc_id` | ID of existing VPC where cluster will be deployed | n/a | n/a |  yes |

## Outputs

| Name | Description |
|------|-------------|
| `cluster_certificate_authority_data` | Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster. |
| `cluster_endpoint` | Endpoint for EKS control plane. |
| `cluster_id` | Name of the EKS cluster |
| `cluster_roles` | Cluster roles to assueme for EKS |
| `cluster_security_group_id` | Security group ID attached to the EKS cluster. |
| `cluster_version` | The Kubernetes server version for the EKS cluster. |
| `config_map_aws_auth` | n/a |
| `kubeconfig` | kubectl config as generated by the module. |
| `worker_iam_role_arn` | default IAM role ARN for EKS worker groups |
| `worker_iam_role_name` | default IAM role name for EKS worker groups |
| `worker_security_group_id` | Security group ID attached to the EKS workers. |
| `workers_asg_arns` | IDs of the autoscaling groups containing workers. |
| `workers_asg_names` | Names of the autoscaling groups containing workers. |

# A Terraform module to create "operations" type of environment.


This module will create an environment suitable for "operations" type of AWS account.
Most important elements of the environment:

* VPC (not created by this module, must exist apriori as it can be only created with a portal)
* Kubernetes cluster (to be used for CI/CD, monitoring, etc.)
* ECR Docker registry


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

}
```


## Outputs

| Name | Description |
|------|-------------|
| cluster_id | - |
| worker_iam_role_name | - |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | Availability Zones for the cluster (1 master per AZ will be deployed) | list | - | yes |
| environment_type | Type of environment (e.g. test, int, e2e, prod) | string | - | yes |
| http_proxy | IP[:PORT] - address and optional port of HTTP proxy to be used to download packages | string | - | yes |
| k8s_allowed_worker_ssh_cidrs | List of CIDR ranges to allow SSH access into worker nodes | list | `<list>` | no |
| k8s_aws_ssh_keypair_name | Optional name of existing SSH keypair on AWS account, to be used for cluster instances (will be generated if not specified) | string | `` | no |
| k8s_enable_cluster_autoscaling | Enable cluster autoscaling | string | `false` | no |
| k8s_enable_pod_autoscaling | Enable horizontal pod autoscaling | string | `false` | no |
| k8s_install_helm | Install Helm during the deployment of the cluster | string | `true` | no |
| k8s_linux_distro | Linux distribution for K8s cluster instances (supported values: debian, amzn2) | string | `debian` | no |
| k8s_master_instance_type | Instance type (size) for master nodes | string | `m4.large` | no |
| k8s_masters_iam_policies_arns | (Optional) List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances) | list | `<list>` | no |
| k8s_node_count | Number of worker nodes in Kubernetes cluster | string | `3` | no |
| k8s_node_instance_type | Instance type (size) for worker nodes | string | `m4.large` | no |
| k8s_nodes_iam_policies_arns | (Optional) List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances) | list | `<list>` | no |
| k8s_private_subnets | List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used) | list | - | yes |
| k8s_protect_cluster_from_scale_in | Protect cluster nodes from scale in (if using cluster autoscaling) | string | `false` | no |
| no_proxy | Comma seperated list of urls to be excluded from proxying. | string | `` | no |
| operations_aws_account_number | AWS operation account number (without hyphens) | string | - | yes |
| product_domain_name | Name of product domain (e.g. maps) | string | - | yes |
| region | AWS region | string | - | yes |
| vpc_id | ID of existing VPC where cluster will be deployed | string | - | yes |
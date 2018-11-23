# A Terraform module to create "operations" type of environment.


This module will create an environment suitable for "operations" type of AWS account.
Most important elements of the environment:

* VPC (not created by this module, must exist apriori as it can be only created with a portal)
* Kubernetes cluster (to be used for CI/CD, monitoring, etc.)
* VPC Endpoint - kinesis-streams service (Interface type)
* kinesis stream (logging)
* elasticsearch domain (logging)
* lambda function (logging - integrates kinesis stream to elasticsearch)


# Notes
* logging part is temporarily disabled and requires testing/improvements


## Usage

```hcl
module "operations" {
  source = "source = "github.com/kentrikos/terraform-aws-account-operations.git"

  product_domain_name              = "${var.product_domain_name}"
  environment_type                 = "${var.environment_type}"

  region                           = "${var.region}"
  azs                              = "${var.azs}"
  vpc_id                           = "${var.vpc_id}"
  k8s_private_subnets              = "${var.k8s_private_subnets}"
  http_proxy                       = "${var.http_proxy}"

  k8s_node_count                   = "${var.k8s_node_count}"
  k8s_master_instance_type         = "${var.k8s_master_instance_type}"
  k8s_node_instance_type           = "${var.k8s_node_instance_type}"

  k8s_masters_iam_policies_arns    = "${var.k8s_masters_iam_policies_arns}"
  k8s_nodes_iam_policies_arns      = "${var.k8s_nodes_iam_policies_arns}"

  # FIXME: temporarily disabled
  #kinesis_role_name       = "${var.kinesis_role_name}"
  #kinesis_iam_policy_arn  = "${var.kinesis_iam_policy_arn}"
  #kinesis_shard_count     = "${var.kinesis_shard_count}"
  #elasticsearch_version   = "${var.elasticsearch_version}"
  #lambda_iam_policy_arn   = "${var.kinesis_role_name}"
}
```


## Outputs

| Name | Description |
|------|-------------|
| elasticsearch_domain_arn | - |
| elasticsearch_domain_name | - |
| elasticsearch_endpoint | - |
| kinesis_role_arn | - |
| kinesis_role_name | - |
| kinesis_stream_name | - |
| kinesis_user_id | - |
| kinesis_user_secret | - |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | Availability Zones for the cluster (1 master per AZ will be deployed) | list | - | yes |
| environment_type | Type of environment (e.g. test, int, e2e, prod) | string | - | yes |
| http_proxy | IP[:PORT] - address and optional port of HTTP proxy to be used to download packages | string | - | yes |
| k8s_master_instance_type | Instance type (size) for master nodes | string | `m4.large` | no |
| k8s_masters_iam_policies_arns | List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances) | list | - | yes |
| k8s_node_count | Number of worker nodes in Kubernetes cluster | string | `3` | no |
| k8s_node_instance_type | Instance type (size) for worker nodes | string | `m4.large` | no |
| k8s_nodes_iam_policies_arns | List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances) | list | - | yes |
| k8s_private_subnets | List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used) | list | - | yes |
| product_domain_name | Name of product domain (e.g. maps) | string | - | yes |
| region | AWS region | string | `eu-central-1` | no |
| vpc_id | ID of existing VPC where cluster will be deployed | string | - | yes |


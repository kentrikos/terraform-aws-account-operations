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
  
  map_roles            = "${var.map_roles}"
  map_roles_count      = "${var.map_roles_count}"
  map_users            = "${var.map_users}"
  map_users_count      = "${var.map_users_count}"
  map_accounts         = "${var.map_accounts}"
  map_accounts_count   = "${var.map_accounts_count}"
  enable_default_roles = "${var.enable_default_roles}"
  
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | Availability Zones for the cluster (1 master per AZ will be deployed) | list | n/a | yes |
| enable\_default\_roles | Enable creation of default roles to assume | string | `"true"` | no |
| environment\_type | Type of environment (e.g. test, int, e2e, prod) | string | n/a | yes |
| http\_proxy | IP[:PORT] - address and optional port of HTTP proxy to be used to download packages | string | n/a | yes |
| k8s\_allowed\_worker\_ssh\_cidrs | List of CIDR ranges to allow SSH access into worker nodes | list | `<list>` | no |
| k8s\_aws\_ssh\_keypair\_name | Optional name of existing SSH keypair on AWS account, to be used for cluster instances (will be generated if not specified) | string | `""` | no |
| k8s\_enable\_cluster\_autoscaling | Enable cluster autoscaling | string | `"false"` | no |
| k8s\_enable\_pod\_autoscaling | Enable horizontal pod autoscaling | string | `"false"` | no |
| k8s\_install\_helm | Install Helm during the deployment of the cluster | string | `"true"` | no |
| k8s\_linux\_distro | Linux distribution for K8s cluster instances (supported values: debian, amzn2) | string | `"debian"` | no |
| k8s\_master\_instance\_type | Instance type (size) for master nodes | string | `"m4.large"` | no |
| k8s\_masters\_iam\_policies\_arns | (Optional) List of existing IAM policies that will be attached to instance profile for master nodes (EC2 instances) | list | `<list>` | no |
| k8s\_node\_count | Number of worker nodes in Kubernetes cluster | string | `"3"` | no |
| k8s\_node\_instance\_type | Instance type (size) for worker nodes | string | `"m4.large"` | no |
| k8s\_nodes\_iam\_policies\_arns | (Optional) List of existing IAM policies that will be attached to instance profile for worker nodes (EC2 instances) | list | `<list>` | no |
| k8s\_private\_subnets | List of private subnets (matching AZs) where to deploy the cluster (required if existing VPC is used) | list | n/a | yes |
| k8s\_protect\_cluster\_from\_scale\_in | Protect cluster nodes from scale in (if using cluster autoscaling) | string | `"false"` | no |
| map\_accounts | Additional AWS account numbers to add to the aws-auth configmap. See terraform-aws-modules-eks examples/basic/variables.tf for example format. | list | `<list>` | no |
| map\_accounts\_count | The count of accounts in the map_accounts list. | string | `"0"` | no |
| map\_roles | Additional IAM roles to add to the aws-auth configmap. See terraform-aws-modules-eks examples/basic/variables.tf for example format. | list | `<list>` | no |
| map\_roles\_count | The count of roles in the map_roles list. | string | `"0"` | no |
| map\_users | Additional IAM users to add to the aws-auth configmap. See terraform-aws-modules-eksexamples/basic/variables.tf for example format. | list | `<list>` | no |
| map\_users\_count | The count of roles in the map_users list. | string | `"0"` | no |
| no\_proxy | Comma seperated list of urls to be excluded from proxying. | string | `""` | no |
| operations\_aws\_account\_number | AWS operation account number (without hyphens) | string | n/a | yes |
| product\_domain\_name | Name of product domain (e.g. maps) | string | n/a | yes |
| region | AWS region | string | n/a | yes |
| vpc\_id | ID of existing VPC where cluster will be deployed | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_certificate\_authority\_data | Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster. |
| cluster\_endpoint | Endpoint for EKS control plane. |
| cluster\_id | Name of the EKS cluster |
| cluster\_roles | Cluster roles to assueme for EKS |
| cluster\_security\_group\_id | Security group ID attached to the EKS cluster. |
| cluster\_version | The Kubernetes server version for the EKS cluster. |
| config\_map\_aws\_auth |  |
| kubeconfig | kubectl config as generated by the module. |
| worker\_iam\_role\_arn | default IAM role ARN for EKS worker groups |
| worker\_iam\_role\_name | default IAM role name for EKS worker groups |
| worker\_security\_group\_id | Security group ID attached to the EKS workers. |
| workers\_asg\_arns | IDs of the autoscaling groups containing workers. |
| workers\_asg\_names | Names of the autoscaling groups containing workers. |

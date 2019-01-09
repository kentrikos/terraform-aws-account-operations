locals {
  cluster_name = "${var.product_domain_name}-${var.environment_type}-ops.k8s.local"

  common_tags = {
    ProjectName = "${var.product_domain_name}"
    Environment = "${var.environment_type}"
    Cluster     = "${local.cluster_name}"
  }
}

# Kubernetes cluster:
module "kubernetes_cluster_operations" {
  source = "github.com/kentrikos/terraform-aws-kops"

  cluster_name_prefix = "${var.product_domain_name}-${var.environment_type}-ops"
  region              = "${var.region}"
  vpc_id              = "${var.vpc_id}"
  azs                 = "${join(",", var.azs)}"
  subnets             = "${join(",", var.k8s_private_subnets)}"
  http_proxy          = "${var.http_proxy}"
  disable_natgw       = "true"

  node_count           = "${var.k8s_node_count}"
  master_instance_type = "${var.k8s_master_instance_type}"
  node_instance_type   = "${var.k8s_node_instance_type}"
  aws_ssh_keypair_name = "${var.k8s_aws_ssh_keypair_name}"

  masters_iam_policies_arns = "${var.k8s_masters_iam_policies_arns}"
  nodes_iam_policies_arns   = "${var.k8s_nodes_iam_policies_arns}"
}

# ECR registry for customized JenkinsX image:
resource "aws_ecr_repository" "jenkins-x-image" {
  name = "jenkins-x-image"
}

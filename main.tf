locals {
  cluster_name = "${var.region}-${var.product_domain_name}-${var.environment_type}-ops"

  common_tags = {
    Terraform       = true
    EnvironmentType = var.product_domain_name
    EnvironmentType = var.environment_type
    Cluster         = local.cluster_name
  }
}

# Kubernetes cluster:
module "kubernetes_cluster_operations" {
  source = "github.com/kentrikos/terraform-aws-eks?ref=4.0.0"

  cluster_prefix                = local.cluster_name
  region                        = var.region
  vpc_id                        = var.vpc_id
  private_subnets               = var.k8s_private_subnets
  http_proxy                    = var.http_proxy
  no_proxy                      = var.no_proxy
  desired_worker_nodes          = var.k8s_node_count
  worker_node_instance_type     = var.k8s_node_instance_type
  key_name                      = var.k8s_aws_ssh_keypair_name
  enable_cluster_autoscaling    = var.k8s_enable_cluster_autoscaling
  enable_pod_autoscaling        = var.k8s_enable_pod_autoscaling
  protect_cluster_from_scale_in = var.k8s_protect_cluster_from_scale_in
  install_helm                  = var.k8s_install_helm
  ingress_deploy                = var.k8s_ingress_deploy
  allowed_worker_ssh_cidrs      = var.k8s_allowed_worker_ssh_cidrs
  allowed_worker_nodeport_cidrs = var.k8s_allowed_worker_nodeport_cidrs

  cluster_version = var.k8s_cluster_version

  map_roles            = var.map_roles
  map_users            = var.map_users
  map_accounts         = var.map_accounts
  enable_default_roles = var.enable_default_roles

  tags = local.common_tags

  ingress_helm_values  = var.ingress_helm_values
  ingress_service_type = var.ingress_service_type

  cluster_enabled_log_types     = var.k8s_cluster_enabled_log_types
  cluster_log_retention_in_days = var.k8s_cluster_log_retention_in_days
}

# ECR registry for customized JenkinsX image:
resource "aws_ecr_repository" "jenkins-x-image" {
  name = "${var.product_domain_name}-${var.environment_type}-jenkins-x-image"
}


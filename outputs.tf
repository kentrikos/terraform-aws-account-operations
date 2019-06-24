output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = "${module.kubernetes_cluster_operations.cluster_endpoint}"
}

output "kubeconfig" {
  description = "kubectl config as generated by the module."
  value       = "${module.kubernetes_cluster_operations.kubeconfig}"
}

output "config_map_aws_auth" {
  description = ""
  value       = "${module.kubernetes_cluster_operations.config_map_aws_auth}"
}

output "cluster_id" {
  description = "Name of the EKS cluster"
  value       = "${module.kubernetes_cluster_operations.cluster_id}"
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = "${module.kubernetes_cluster_operations.cluster_certificate_authority_data}"
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = "${module.kubernetes_cluster_operations.cluster_version}"
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster."
  value       = "${module.kubernetes_cluster_operations.cluster_security_group_id}"
}

output "workers_asg_arns" {
  description = "IDs of the autoscaling groups containing workers."
  value       = "${module.kubernetes_cluster_operations.workers_asg_arns}"
}

output "workers_asg_names" {
  description = "Names of the autoscaling groups containing workers."
  value       = "${module.kubernetes_cluster_operations.workers_asg_names}"
}

output "worker_security_group_id" {
  description = "Security group ID attached to the EKS workers."
  value       = "${module.kubernetes_cluster_operations.worker_security_group_id}"
}

output "worker_iam_role_name" {
  description = "default IAM role name for EKS worker groups"
  value       = "${module.kubernetes_cluster_operations.worker_iam_role_name}"
}

output "worker_iam_role_arn" {
  description = "default IAM role ARN for EKS worker groups"
  value       = "${module.kubernetes_cluster_operations.worker_iam_role_arn}"
}

output "cluster_roles" {
  description = "Cluster roles to assueme for EKS"
  value       = "${module.kubernetes_cluster_operations.cluster_roles}"
}

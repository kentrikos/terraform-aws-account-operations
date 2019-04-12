output "cluster_id" {
  value = "${module.kubernetes_cluster_operations.cluster_id}"
}

output "worker_iam_role_name" {
  value = "${module.kubernetes_cluster_operations.worker_iam_role_name}"
}

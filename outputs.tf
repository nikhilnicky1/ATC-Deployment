# outputs.tf

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.webapp_eks.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.webapp_eks.endpoint
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.webapp_vpc.id
}
resource "aws_iam_role_policy_attachment" "secrets_manager_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role      = aws_iam_role.webapp_role.name 
}

# Attach policies to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "webapp_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role     = aws_iam_role.webapp_eks_cluster_role.name
}

# Attach policies to EKS Nodes Role
resource "aws_iam_role_policy_attachment" "webapp_eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role     = aws_iam_role.webapp_eks_nodes_role.name
}
# Attach AmazonEKS_CNI_Policy to EKS Nodes Role
resource "aws_iam_role_policy_attachment" "webapp_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.webapp_eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "webapp_ec2_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role     = aws_iam_role.webapp_eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "eks_permissions_attachment" {
  policy_arn = aws_iam_policy.eks_permissions.arn
  role       = aws_iam_role.webapp_eks_cluster_role.name
}

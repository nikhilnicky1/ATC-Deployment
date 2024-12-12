# webapp_eks.tf
resource "aws_eks_cluster" "webapp_eks" {
  name     = "webapp-eks"
  role_arn = aws_iam_role.webapp_eks_cluster_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids         = [
      aws_subnet.webapp_public_subnet_a.id,
      aws_subnet.webapp_public_subnet_b.id,
      aws_subnet.webapp_private_subnet_a.id,
      aws_subnet.webapp_private_subnet_b.id,

    ]
    security_group_ids = [aws_security_group.webapp_eks_sg.id]  # Attach security group to the cluster
  }

  tags = {
    Name = "webapp_eks"
  }
}

resource "aws_eks_node_group" "webapp_node_group" {
  cluster_name    = aws_eks_cluster.webapp_eks.name
  node_group_name = "webapp-nodes"
  node_role_arn   = aws_iam_role.webapp_eks_nodes_role.arn
  ami_type        = "AL2_x86_64"
  instance_types = ["t3.medium"]
  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  subnet_ids = [
    aws_subnet.webapp_public_subnet_a.id,
    aws_subnet.webapp_public_subnet_b.id,
    aws_subnet.webapp_private_subnet_a.id,
    aws_subnet.webapp_private_subnet_b.id,
  ]

  tags = {
    Name = "webapp-nodes"
  }
}


resource "null_resource" "update_kubeconfig" {
  depends_on = [aws_eks_cluster.webapp_eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${aws_eks_cluster.webapp_eks.name} --region ${var.aws_region}"
  }
}

resource "null_resource" "wait_for_cluster" {
  depends_on = [aws_eks_cluster.webapp_eks]

  provisioner "local-exec" {
    command = "powershell -Command \"while ((aws eks describe-cluster --name ${aws_eks_cluster.webapp_eks.name} --query 'cluster.status' --output text) -ne 'ACTIVE') { Start-Sleep -Seconds 10 }\""
  }
}


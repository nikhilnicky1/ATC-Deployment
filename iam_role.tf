resource "aws_iam_role" "webapp_role" {
  name = "webapp_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Adjust this for your use case
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# New IAM Role for EKS Cluster
resource "aws_iam_role" "webapp_eks_cluster_role" {
  name = "webapp_eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# New IAM Role for EKS Nodes
resource "aws_iam_role" "webapp_eks_nodes_role" {
  name = "webapp_eks_nodes_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
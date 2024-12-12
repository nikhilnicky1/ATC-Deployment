resource "aws_iam_policy" "eks_permissions" {
  name        = "EKSPermissions"
  description = "Policy for EKS permissions"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:ListNodegroups",
          "eks:DescribeNodegroup"
        ]
        Resource  = "*"
      }
    ]
  })
}

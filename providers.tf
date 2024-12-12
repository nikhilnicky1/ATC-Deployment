provider "aws" {
  profile = "default"
  region     = var.aws_region
}

provider "kubernetes" {
  config_path = "~/.kube/config" # Ensure this path is correct
}

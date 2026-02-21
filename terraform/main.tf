# Definição do Provedor (AWS)
provider "aws" {
  region = "us-east-1"
}

# 1. Criação da VPC (Rede Virtual) para a Loja Veloz
resource "aws_vpc" "loja_veloz_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "loja-veloz-vpc"
  }
}

# 2. Cluster Kubernetes (EKS)
resource "aws_eks_cluster" "loja_veloz_cluster" {
  name     = "loja-veloz-prod"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  }
}

# 3. Node Group (As máquinas que vão rodar os pods)
resource "aws_eks_node_group" "loja_veloz_nodes" {
  cluster_name    = aws_eks_cluster.loja_veloz_cluster.name
  node_group_name = "worker-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  scaling_config {
    desired_size = 2
    max_size     = 5 # Escalabilidade automática (Auto Scaling)
    min_size     = 1
  }

  instance_types = ["t3.medium"]
}

# Output para conectar o kubectl depois
output "endpoint" {
  value = aws_eks_cluster.loja_veloz_cluster.endpoint
}


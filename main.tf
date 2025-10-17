data "kops_kube_config" "kube_config" {
  cluster_name = var.cluster_name
}

resource "aws_secretsmanager_secret" "cluster_secret" {
  name = "argocd/clusters/${var.cluster_name}"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "cluster_secret_value" {
  secret_id = aws_secretsmanager_secret.cluster_secret.id
  secret_string = jsonencode({
    cluster_ca_certificate = base64encode(data.kops_kube_config.kube_config.ca_certs)
    host                   = data.kops_kube_config.kube_config.server
    name                   = var.cluster_name
    role_arn               = var.role_arn
  })
}

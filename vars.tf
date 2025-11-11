variable "cluster_name" {
  type        = string
  description = "the name of the cluster which to create a secret for"
}

variable "argocd_cluster_secret" {
  type        = bool
  default     = false
  description = "whether this is the cluster secret for the ArgoCD cluster it-self. Will create different ExternalSecret value"
}

# TODO Perhaps just pass account_id
variable "role_arn" {
  type        = string
  description = "the ARN of the role to give access to the cluster, for example arn:aws:iam::12456789012:role/KubernetesAdmin"
}

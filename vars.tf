variable "cluster_name" {
  type        = string
  description = "the name of the cluster which to create a secret for"
}

# TODO Perhaps just pass account_id
variable "role_arn" {
  type        = string
  description = "the ARN of the role to give access to the cluster, for example arn:aws:iam::12456789012:role/KubernetesAdmin"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "tags to apply to the secret in AWS SecretsManager"
}

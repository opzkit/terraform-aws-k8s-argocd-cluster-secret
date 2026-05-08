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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "tags to apply to the secret in AWS SecretsManager"
}

variable "recovery_window_in_days" {
  type        = number
  default     = 30
  description = "Number of days AWS Secrets Manager waits before permanently deleting the secret. Set to 0 to delete immediately (useful for ephemeral clusters that get rebuilt frequently). Otherwise must be between 7 and 30."

  validation {
    condition     = var.recovery_window_in_days == 0 || (var.recovery_window_in_days >= 7 && var.recovery_window_in_days <= 30)
    error_message = "recovery_window_in_days must be 0 or between 7 and 30."
  }
}

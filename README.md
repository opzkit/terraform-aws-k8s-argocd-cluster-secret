# terraform-aws-k8s-argocd-cluster-secret

Create AWS Secrets for k8s cluster config (to be used with ArgoCD) and
[cluster secrets](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#clusters)

Preferably used together with the [terraform-aws-k8s](https://github.com/opzkit/terraform-aws-k8s)
module!

It requires a [kOps](https://kops.sigs.k8s.io/) cluster to work.

## Usage
To create a secret for a cluster:

```terraform
module "k8s_cluster_config" {
  source       = "opzkit/k8s-argocd-cluster-secret/aws"
  version      = "0.0.4"
  providers    = {
    aws = aws
  }
  cluster_name = "test-cluster"
  role_arn     = "arn:aws:iam::${local.account_id}:role/KubernetesAdmin"
}
```
This will create a secret (in the AWS account passed as a `provider`) named `argocd/clusters/test-data`.

Then for example an [Kubernetes ExternalSecret](https://github.com/external-secrets/kubernetes-external-secrets) can be
used to create an ArgoCD cluster secret:

```yaml
apiVersion: kubernetes-client.io/v1
kind: ExternalSecret
metadata:
  name: test-cluster
  namespace: argocd
spec:
  backendType: secretsManager
  dataFrom:
    - argocd/clusters/test-cluster
  template:
    metadata:
      labels:
        argocd.argoproj.io/secret-type: cluster
    stringData:
      name: <%= data.name %>
      server: <%= data.host %>
      config: |
        {
          "tlsClientConfig": {
            "insecure": false,
            "caData": <%= data.cluster_ca_certificate %>
          },
          "awsAuthConfig": {
            "clusterName": <%= data.name %>,
            "roleARN": <%= data.role_arn %>
          }
        }
```

Using [ExternalSecret](https://github.com/external-secrets/external-secrets):

```yaml

apiVersion: external-secrets.io/v1alpha1
kind: ExternalSecret
metadata:
  name: test-cluster
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: cluster
spec:
  refreshInterval: 30s
  secretStoreRef:
    name: external-secrets
    kind: ClusterSecretStore
  target:
    creationPolicy: Owner
    template:
      data:
        name: "{{ (.data | fromJSON).name }}"
        server: "{{ (.data | fromJSON).host }}"
        config: |
          {
            "tlsClientConfig": {
              "insecure": false,
              "caData": "{{ (.data | fromJSON).cluster_ca_certificate }}"
            },
            "awsAuthConfig": {
              "clusterName": "{{ (.data | fromJSON).name }}",
              "roleARN": "{{ (.data | fromJSON).role_arn }}"
            }
          }
  data:
    - secretKey: data
      remoteRef:
        key: argocd/clusters/test-cluster
```


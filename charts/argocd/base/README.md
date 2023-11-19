# Argocd - kustomize

Currently I have this weird bug that if I use the template files on nixos there are no issues. However, when I update argocd helm chart to `5.51.2` there is an error about my `kubernetes` version being 1.20 even though I have 1.27.
```bash
Error: chart requires kubeVersion: >=1.23.0-0 which is incompatible with Kubernetes v1.20.0
```
## Usage

Ensure you have kubectl, helm, argo-cd, kustomize before running the install command:
```bash
kustomize build --enable-helm devops/overlays/prod | kubectl apply -f -
```

Consult the [docs](https://argo-cd.readthedocs.io/en/stable/getting_started/) but essentially, if using linode, check the load balancer that is provisioned and retrieve its `Hostname`. Navigate to it and then retrieve the inital password:

```bash
argocd admin initial-password -n argocd
```

## Configuration

Add the `infra` repo and an ssh key:
`kubectl create secret generic my-ssh-secret --from-file=sshPrivateKey=/path/to/your/private/key`

Then add your ssh + repo using argocd

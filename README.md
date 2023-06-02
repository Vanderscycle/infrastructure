# k8s personal infrastructure

Hosted on linode using terraform and terraform cloud

## spin new instance

1. cd into ./charts/argocd/overlays/prod/
2. kustomize build --load-restrictor LoadRestrictionsNone --enable-helm . | k apply -f -
3. change the password https://argo-cd.readthedocs.io/en/stable/getting_started/
4. add the github repo
5. configure sealed-secrets <- where I am 

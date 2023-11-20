# k8s personal infrastructure

Hosted on linode using terraform and terraform cloud

## spin new instance

0. import the kubeconfig.yaml file into $HOME/.kube/infrastructure-kubeconfig.yaml
set -xg KUBECONFIG $HOME/.kube/infrastructure-kubeconfig.yaml
1. cd into ./charts/argocd/overlays/prod/
2. kustomize build --load-restrictor LoadRestrictionsNone --enable-helm . | k apply -f -
3. change the password https://argo-cd.readthedocs.io/en/stable/getting_started/
4. add the github repo
5. fetch sealed secret key kubeseal --fetch-pem > kubeseal-public.pem

## Cloud

Using Linode to host

## Resources
- terraform
- yaml
- k8s



TODO: (18/11/2023)

good progress
have the domain names + lke up
get the sealed secrets back working again

fix the professional website (new branch) and serve it no backend
get a dns up + a few chart services too (get confident again with kubectl)
progress on 3d printer

later:
figure out the rpi cluster

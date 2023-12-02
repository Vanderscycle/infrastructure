# k8s personal infrastructure

Hosted on linode using terraform and terraform cloud

## spin new instance

0. import the kubeconfig.yaml file into $HOME/.kube/infrastructure-kubeconfig.yaml
set -xg KUBECONFIG $HOME/.kube/infrastructure-kubeconfig.yaml
1. cd into ./charts/argocd/overlays/prod/
2. kustomize build --load-restrictor LoadRestrictionsNone --enable-helm . | k apply -f -
3. change the password https://argo-cd.readthedocs.io/en/stable/getting_started/
4. add the github repo
5. fetch cluster kubeseal perms
```
 kubectl get secret -n kube-system -l sealedsecrets.bitnami.com/sealed-secrets-key -o jsonpath="{.items[*].data['tls\.crt']}" | base64 --decode > kubeseal-public.pem
```
6. reseal all the secrets :
```
kubeseal --format yaml --cert='../../../../../kubeseal-public.pem' < secret.yaml > sealed-secret.yaml
```
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

- [ ] For nextcloud to work in production we want to have a db associated with it.
- [ ] add a kustomize replace for all of argocd apps for prod/non-prod
- [ ] create sealed-secrets for postgres dbs (this repo + 3d printer )
- [ ] create a test chart to quickly test new dns names
- [ ] something like uptime-kuma to check that the dns pages are live. Maybe there's something like new relic but free.

- [ ] update profesional-website namespace + format (kustomize)

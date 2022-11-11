#!/bin/bash

# activating the server
kubectl port-forward svc/argocd-server -n argocd 8080:443  & disown

# login
NODE_BALANCE_IP="localhost:8080"
KEY_PATH="$HOME/.ssh/endeavourGit"
TEMP_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
echo -e "$TEMP_PASS"
argocd login "$NODE_BALANCE_IP" \
  --password "$TEMP_PASS" \
  --username admin 

# adds the relevant repo
argocd repo add git@github.com:Vanderscycle/infrastructure.git \
  --ssh-private-key-path "$KEY_PATH" \
  --insecure-ignore-host-key \
  --name infrastructure

# changing the password to one previously defined
argocd account update-password \
  --current-password "$TEMP_PASS" \
  --new-password "$ARGO_LOCAL"


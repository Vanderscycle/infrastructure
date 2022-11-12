#!/bin/bash
kubectl -n vault create secret tls tls-ca \
 --cert ./ca.pem  \
 --key ./ca-key.pem

kubectl -n vault create secret tls tls-server \
  --cert ./vault.pem \
  --key ./vault-key.pem

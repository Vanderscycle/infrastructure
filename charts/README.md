# charts

## In Use

- [nextcloud](https://artifacthub.io/packages/helm/nextcloud/nextcloud)

## What looks right

```
 ❯ tree  -d -L 2
.
├── argocd
│   ├── base
│   └── overlays
├── cicd
│   └── secrets
├── cloud
│   └── nextcloud
├── gitea
│   └── secrets
├── kubeseal
│   ├── base
│   ├── overlays
│   └── sealed_secret_generator
├── monitoring
│   ├── prometheus
│   └── uptime-kuma
├── servers
│   ├── factorioSpaceEx
│   └── factorioVanilla
└── support
    ├── cert-manager
    ├── external-dns
    └── ingress-nginx
```

A good argocd app folder using dns:

```
 ❯ tree  -L 3 cloud/nextcloud/
cloud/nextcloud/
├── base
│   ├── certificate.yaml
│   ├── kustomization.yaml
│   ├── README.md
│   ├── secrets
│   │   ├── kustomization.yaml
│   │   ├── sealed-secret.yaml
│   │   └── secret.yaml
│   └── values.yaml
└── overlays
    ├── non-prod
    │   └── kustomization.yaml
    └── prod
        ├── kustomization.yaml
        ├── namespace.yaml
        └── values.yaml
```

# only for localhost testing
install-kind:
	kind create cluster --config ./localhost/kind.yaml
	kubectl cluster-info -- context kind-infrastructure-localhost

install-argo:
	helm repo add argo https://argoproj.github.io/argo-helm
	# helm install argocd argo/argo-cd --version 5.13.8 --namespace argocd --create-namespace --values ./charts/argocd/values.yaml
	helm template argocd argo/argo-cd --version 5.13.8 --namespace argocd --create-namespace --values ./charts/argocd/base/values.yaml > ./charts/argocd/base/argocd.yaml
	kubectl apply -k ./charts/argocd/overlays/prod/
	# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	sleep 20
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
	bash ./localhost/argocd-login.sh

purge: 
	kind delete clusters infrastructure-localhost

activate:
	kubectl apply -k ./argocd/overlays/dev

secret:
	kubeseal --fetch-cert > kubeseal-public.pem
	kubeseal --cert kubeseal-public.pem -f ./charts/gitea-kustomize/secrets/secret.yaml -o yaml > ./charts/gitea-kustomize/secrets/sealed-secret.yaml
	kubectl apply -k ./charts/gitea-kustomize/secrets/

localhost:
	kubectl port-forward svc/argocd-server -n argocd 8080:443 & disown
	kubectl port-forward svc/consul-consul-server -n vault 8500:8500 & disown
	# kubectl port-forward svc/gitea-http -n git 3000:3000 & disown

connect: # Not working
	export KUBECONFIG="${HOME}"/Documents/infrastructure/Infrastructure-kubeconfig.yaml
	set -xg KUBECONFIG "$HOME"/Documents/infrastructure/Infrastructure-kubeconfig.yaml
	# export KUBECONFIG=$HOME/Documents/infrastructure/Infrastructure-kubeconfig.yaml  

# only for localhost testing
kind-create:
	# docker-crmAll
	(cd ./localhost && bash run.sh)

install-argo:
	kubectl apply -k ./charts/argocd/overlays/prod/
	# kubectl port-forward svc/argocd-server -n argocd 8080:443 & disown
	# bash ./localhost/argocd-login.sh

helm-update:
	helm repo add argo https://argoproj.github.io/argo-helm
	helm template argocd argo/argo-cd --version 5.16.9 --namespace argocd --create-namespace --values ./charts/argocd/base/values.yaml > ./charts/argocd/base/argocd.yaml
	helm repo add factorio-server-charts https://sqljames.github.io/factorio-server-charts/
	helm template factorio-server-charts  factorio-server-charts/factorio-server-charts --version 1.2.0 --namespace servers --create-namespace --values ./charts/servers/values.yaml > ./charts/servers/factorio-helm.yaml

purge: 
	kind delete clusters infrastructure-localhost

activate:
	kubectl apply -k ./argocd/overlays/dev

secret:
	kubeseal --fetch-cert > kubeseal-public.pem
	kubeseal --cert kubeseal-public.pem -f ./charts/cicd/secrets/secret.yaml -o yaml > ./charts/cicd/secrets/sealed-secret.yaml
	kubectl apply -k ./charts/cicd/secrets/

localhost:
	kubectl port-forward svc/argocd-server -n argocd 8080:443 & disown
	# kubectl port-forward svc/consul-consul-server -n vault 8500:8500 & disown
	# kubectl port-forward svc/gitea-http -n git 3000:3000 & disown

connect: # Not working
	export KUBECONFIG="${HOME}"/Documents/infrastructure/Infrastructure-kubeconfig.yaml
	set -xg KUBECONFIG "$HOME"/Documents/infrastructure/Infrastructure-kubeconfig.yaml
	# export KUBECONFIG=$HOME/Documents/infrastructure/Infrastructure-kubeconfig.yaml  

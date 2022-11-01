install:
	kind create cluster --config ./localhost/kind.yaml
	kubectl cluster-info -- context kind-infrastructure-localhost
	helm repo add argo https://argoproj.github.io/argo-helm
	helm install argocd argo/argo-cd --version 5.12.2 --namespace argocd --create-namespace
	# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
	bash ./localhost/argocd-login.sh

purge: 
	kind delete clusters infrastructure-localhost

localhost:
	kubectl port-forward svc/argocd-server -n argocd 8080:443  & disown
	# kubectl port-forward svc/gitea-http -n git 3000:3000 & disown

connect: # Not working
	export KUBECONFIG="${HOME}"/Documents/infrastructure/Infrastructure-kubeconfig.yaml
	# export KUBECONFIG=$HOME/Documents/infrastructure/Infrastructure-kubeconfig.yaml  

login:
	bash ./localhost/argocd-login.sh

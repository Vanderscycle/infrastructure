install:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

localhost:
	kubectl port-forward svc/argocd-server -n argocd 8080:443  & disown
	kubectl port-forward svc/gitea-http -n git 3000:3000 & disown

connect:
	export KUBECONFIG=Infrastructure-kubeconfig.yaml
	# set -xg KUBECONFIG Infrastructure-kubeconfig.yaml
	kubectl get node

argo-cd:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

login:
	bash ./localhost/argocd-login.sh

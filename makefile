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

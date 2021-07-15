k = kubectl --insecure-skip-tls-verify
private_key = $(shell cat ~/.ssh/jenkins)
ingress-controller = https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/aws/deploy.yaml
storageclass = https://raw.githubusercontent.com/spetek/jenkins-Statefulset-StorageClass/main/sc.yaml
secret = https://raw.githubusercontent.com/spetek/jenkins-Statefulset-StorageClass/main/DB-secret.yaml
jenkins = https://raw.githubusercontent.com/spetek/jenkins-Statefulset-StorageClass/main/jenkins-v3.yaml
jenkins_role = https://raw.githubusercontent.com/spetek/jenkins-Statefulset-StorageClass/main/clusterrole-binding.yaml
start:
	@echo "Jenkins is starting."
	@$k apply -f $(storageclass)
	@$k create ns webapi-dev
	@$k apply -f $(jenkins)
	@$k apply -f $(jenkins_role)
	@$k apply -f $(secret)
	@$k apply -f $(ingress-controller)
	@echo $(private_key)
	@$k get pod,svc
delete:
	@echo "Jenkins deleting process is started."
	@$k delete -f $(jenkins)
	@$k delete -f $(jenkins_role)
	@$k delete -f $(secret)
	@$k delete -f $(storageclass)
	@$k delete -f $(ingress-controller)
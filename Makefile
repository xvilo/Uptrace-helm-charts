NAMESPACE := uptrace
RELEASE_NAME := my-uptrace

create-namespace:
	kubectl create namespace $(NAMESPACE)

delete-namespace:
	kubectl delete namespace $(NAMESPACE)

debug:
	helm install --dry-run --debug $(RELEASE_NAME) ./charts/uptrace

lint:
	helm lint --strict --set "cloud=local" ./charts/uptrace

install:
	helm install $(RELEASE_NAME) ./charts/uptrace -n $(NAMESPACE)

uninstall:
	helm uninstall -n $(NAMESPACE) $(RELEASE_NAME)

delete: uninstall
	kubectl delete all,pvc,cm --all -n $(NAMESPACE)

upgrade:
	helm upgrade $(RELEASE_NAME) -n $(NAMESPACE) --create-namespace

list:
	kubectl get all -n $(NAMESPACE)

list-all:
	kubectl get all,pvc,cm -n $(NAMESPACE)

re-install: delete install

purge: delete delete-namespace

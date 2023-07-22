## High Level Steps

**Private Access Use Case**

1. Deploy nginx-ingress chart with Helm **(internal-ingress-controller)**

```
./helm.sh
helm ls -A 
```

2. Deploy sample app **(guestbook-app)** with one .yaml file at a time or "kubectl apply -f ." for all

```
kubectl apply -f <.yaml>
kubectl get service # gather external IP for testing
kubectl get deploy
kubectl get pods 
kubectl get ingress
```

3. Deploy consumer VM **(4 - internal-consumer)**

```
terraform init
terraform plan
terraform apply
```

4. Test connectivity from consumer to VM to External IP (ingress controller), see sample output:

```
azureuser@aks-consumer-vm:~$ curl http://40.100.0.105
<html ng-app="redis">
  <head>
    <title>Guestbook</title>
    <<< output ommitted for brevity >>>
```


**Clean up**

```
helm repo list 
helm repo remove
helm ls -A 
helm uninstall ingress-nginx
kubectl delete deployment -l app=redis
kubectl delete service -l app=redis
kubectl delete deployment frontend
kubectl delete service frontend
kubectl delete ingress guestbook
kubectl -n default get all
terraform destroy
```


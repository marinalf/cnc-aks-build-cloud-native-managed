## High Level Steps

For brevity, the same app is being exposed privately and publicly with dedicated ingress controllers. Also, only HTTP is being used. 

***Private Access Use Case***

1. Deploy nginx-ingress chart with Helm **(internal-ingress-controller)**

```
./helm.sh
helm ls -A 
```

2. Deploy sample app **(guestbook-app-internal)** with one .yaml file at a time or "kubectl apply -f ." for all

```
kubectl apply -f <.yaml>
kubectl get services # Gather "External IP" for testing
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

4. Test connectivity from consumer VM to External IP (ingress controller). See sample output:

```
azureuser@aks-consumer-vm:~$ curl http://40.100.0.105
<html ng-app="redis">
  <head>
    <title>Guestbook</title>
    <<< output ommitted for brevity >>>
```

***Public Access Use Case***

1. Deploy nginx-ingress-external chart with Helm **(external-ingress-controller)**

```
./helm.sh
helm ls -A 
```

2. Deploy ingress route for public access **(guestbook-app-external)**

```
kubectl apply -f ingress-route-external.yaml
kubectl get services # Gather "External IP" for testing
```
3. Open any browser to verify access to guest book app using its public IP

**Clean Up**

```
helm repo list 
helm repo remove
helm ls -A 
helm uninstall ingress-nginx
helm uninstall ingress-nginx-external
kubectl delete deployment -l app=redis
kubectl delete service -l app=redis
kubectl delete deployment frontend
kubectl delete service frontend
kubectl delete ingress guestbook
kubectl delete ingress guestbook-external
kubectl -n default get all
terraform destroy
```


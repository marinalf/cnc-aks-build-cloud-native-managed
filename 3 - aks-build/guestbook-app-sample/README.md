## High Level Steps

Deploy one .yaml file at a time, or use "kubectl apply -f ." to deploy all

```
kubectl apply -f <.yaml>
kubectl get service (gather external IP for testing)
kubectl get deploy
kubectl get pods 
kubectl exec <frontend-name> -- curl http://localhost
``````
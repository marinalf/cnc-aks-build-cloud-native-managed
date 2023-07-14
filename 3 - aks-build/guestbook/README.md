## Deploy one at a time, or use "kubectl apply -f ." to deploy all

1. Create Backend Master deployment

```
kubectl apply -f backend-deploy-redis-master.yaml
```
2. Create Backend  Master service 

```
kubectl apply -f backend-service-redis-master.yaml
```
3. Create Backend replica deployment

```
kubectl apply -f backend-deploy-redis-replica.yaml
```
4. Create Backend replica service 

```
 kubectl apply -f backend-service-redis-replica.yaml
```
5. Create frontend deployment

```
 kubectl apply -f frontend-deploy-php-redis.yaml
```
6. Create frontend service 

```
kubectl apply -f frontend-service-php-redis.yaml
```
7. Verification Commands

```
kubectl get deploy
kubectl get pods 
kubectl get service
kubectl exec <frontend-name> -- curl http://localhost
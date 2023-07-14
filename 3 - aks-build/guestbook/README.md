## Deploy one at a time, or use "kubectl apply -f ." to deploy all

1. Create Backend Master deployment

```
kubectl apply -f Back-end-Deploy-Redis-Master-Guest-Book-App.yaml
```
2. Create Backend  Master service 

```
kubectl apply -f Back-end-service-Redis-Master-Guest-Book-App.yaml
```
3. Create Backend slave deployment

```
kubectl apply -f Back-end-Deploy-Redis-slave-Guest-Book-App.yaml
```
4. Create Backend slave service 

```
 kubectl apply -f Back-end-service-Redis-slave-Guest-Book-App.yaml
```
5. Create frontend deployment

```
 kubectl apply -f Front-end-Deploy-Redis-php-Guest-Book-App.yaml 
```
6. Create front-end-service 

```
kubectl apply -f Front-end-service-Redis-php-Guest-Book-App.yaml
```
7. Verification Commands

```
kubectl get deploy
kubectl get pods 
kubectl get service
kubectl exec <frontend-name> -- curl http://localhost
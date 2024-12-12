# Kubernetes Deployment and Service Documentation
##### This guide explains the configuration and deployment of a Kubernetes application using a single manifest file that defines both a Deployment and a Service.

### **Overview**
##### The provided manifest file deploys a web application with the following configurations:

**Deployment**: Manages application pods with two replicas.
**Service**: Exposes the application externally using a LoadBalancer.

# steps
### 1. Create a manifest file and save it.
### **`webapp-deployment-service.yml`**
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp
        image: chittimallanikhil/web-app
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: webapp-service
spec:
  selector:
    app: webapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
```
### 2. Apply the file using kubectl:
```bash
kubectl apply -f webapp-deployment-service.yml
```
### 3. Verify the Deployment and Service:
### Check the pods:
```bash
kubectl get pods
```
### Check the service:
```bash
kubectl get services
```
#### Note the external IP assigned to the service (available after a few moments):
```bash
kubectl get service webapp-service
```
### 4. Verification
#### Access the application using the external IP of the service on port 80:

**http://localhost:80**
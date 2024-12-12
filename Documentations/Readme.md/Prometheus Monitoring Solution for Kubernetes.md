# Prometheus Monitoring Solution for Kubernetes

##### This guide provides step-by-step instructions for deploying Prometheus to monitor a Kubernetes cluster and its applications.

### **Prerequisites**
- Kubernetes Cluster: A running Kubernetes cluster.
- Helm Installed: Install Helm if not already available.
- kubectl Installed: Ensure kubectl is configured to access the cluster.
## Steps :
#### **Step 1**: Add Prometheus Helm Chart Repository
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
# This command adds the official Prometheus community repository and updates the Helm repository cache.
```

#### Step 2: Install Prometheus

Install Prometheus using the Helm chart:
```bash
helm install prometheus prometheus-community/prometheus
```
This installs Prometheus in the default namespace. To install it in a specific namespace, use:
```bash
helm install prometheus prometheus-community/prometheus -n <namespace> --create-namespace
```
#### Step 3: Verify the Installation

```bash
helm list -n default
```
#### Step 4: Verify Prometheus pods are running:
```bash
kubectl get pods -n default
```

#### Step 5: Access Prometheus UI

Forward the Prometheus server port to your local machine: (windows)
```bash
$POD_NAME = kubectl get pods --namespace default -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}"

kubectl --namespace default port-forward $POD_NAME 9090
```
Access the Prometheus web interface in your browser:
#### **http://localhost:9090**

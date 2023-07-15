### About <a name = "about"></a>

This is a sample terraform code to automate networking and policies for AKS with [Cloud Network Controller](https://www.cisco.com/c/en/us/solutions/data-center-virtualization/application-centric-infrastructure/cloud-network-controller.html) policy model.

### Prerequisites

1. CNC First Time setup completed
2. Azure and AKS CLI installed

```
 az aks install-cli
 az login
 az account set --subscription <aks_subscription>
```

### High Level Steps

1. Deploy VNet networking for AKS **(1 - vnet-networking)**
2. Deploy VNet policies for AKS **(2 - vnet-policies)**
3. Define a Service EPG with Cloud Native Managed type (pending resource)
4. Associate Service EPG as provider with internet-access contract
5. Deploy AKS **(3 - aks-build)**

### Verify AKS Cluster Status

Once deployed, get credentials and verify nodes are up.

```
az aks get-credentials --resource-group <rg-name> --name <aks-cluster-name> --admin
kubectl get nodes -o wide
```
### Deploy Sample App

1. Deploy guestbook app **(3 - aks-build/guestbook-app)**
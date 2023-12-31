# Create AKS cluster
## Example: https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks"
  resource_group_name = data.azurerm_resource_group.rg_name.name
  location            = data.azurerm_resource_group.rg_name.location
  dns_prefix          = "myakscluster"
  kubernetes_version  = "1.25.6"

  default_node_pool {
    name                = "agentpool"
    node_count          = 3
    vm_size             = "Standard_DS2_v2"
    vnet_subnet_id      = data.azurerm_subnet.aks_subnet.id
  }
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
   identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}









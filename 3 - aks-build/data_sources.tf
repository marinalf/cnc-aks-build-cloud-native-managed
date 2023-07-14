
# Link to main folder and outputs

data "terraform_remote_state" "cnc" {
  backend = "local"

  config = {
    path = "../1 - vnet-networking/terraform.tfstate"
  }
}

# Existing resources created by CNC

data "azurerm_resource_group" "rg_name" {
  name = data.terraform_remote_state.cnc.outputs.rg-name
}

data "azurerm_virtual_network" "vnet" {
  name                = data.terraform_remote_state.cnc.outputs.vnet
  resource_group_name = data.azurerm_resource_group.rg_name.name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name = data.azurerm_resource_group.rg_name.name
  virtual_network_name = data.terraform_remote_state.cnc.outputs.vnet
}
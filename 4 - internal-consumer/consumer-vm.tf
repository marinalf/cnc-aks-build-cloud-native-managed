terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.36.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {
    template_deployment {
      delete_nested_items_during_deletion = true
    }
  }
}

#Consumer VM

resource "azurerm_linux_virtual_machine" "ask_consumer_vm" {
  name                            = "${var.aks_consumer_prefix}-vm"
  resource_group_name             = data.terraform_remote_state.cnc.outputs.rg-name
  location                        = data.terraform_remote_state.cnc.outputs.region
  size                            = "Standard_D2s_v3"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.aks_consumer_nic.id,
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_network_interface" "aks_consumer_nic" {
  name                = "${var.aks_consumer_prefix}-nic"
  resource_group_name = data.terraform_remote_state.cnc.outputs.rg-name
  location            = data.terraform_remote_state.cnc.outputs.region

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.cnc_consumer_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.aks_consumer_pip.id
  }
}

resource "azurerm_public_ip" "aks_consumer_pip" {
  name                = "${var.aks_consumer_prefix}-nic"
  resource_group_name = data.terraform_remote_state.cnc.outputs.rg-name
  location            = data.terraform_remote_state.cnc.outputs.region
  allocation_method   = "Dynamic"
}

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

data "azurerm_virtual_network" "cnc_aks_vnet" {
  name                = data.terraform_remote_state.cnc.outputs.vnet
  resource_group_name = data.azurerm_resource_group.rg_name.name
}

data "azurerm_subnet" "cnc_consumer_subnet" {
  name                 = data.terraform_remote_state.cnc.outputs.consumer-subnet
  virtual_network_name = data.terraform_remote_state.cnc.outputs.vnet
  resource_group_name  = data.azurerm_resource_group.rg_name.name
}
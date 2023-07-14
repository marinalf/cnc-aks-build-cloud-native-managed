
# CNC Credentials & Azure Subscription

variable "username" {}
variable "password" {}
variable "url" {}
variable "subscription_id" {}

variable "tenant_name" {
  default = "dc1"
}

variable "cloud_vendor" {
  default = "azure"
}

# VNet AKS variables

variable "vnet_aks_name" {
  default = "aks"
}

variable "cxt_vnet_aks" {
  default = "ctx-vnet-aks"
}

variable "vnet_aks_cidr" {
  default = "40.100.0.0/16"
}

variable "vnet_aks_region" {
  default = "japaneast"
}

variable "vnet_aks_subnets" {
  type = map(object({
    name = string
    ip   = string
  }))
  default = {
    subnet1 = {
      name = "aks-subnet"
      ip   = "40.100.0.0/21"
    }
  }
}

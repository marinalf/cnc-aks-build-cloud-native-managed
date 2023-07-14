
# CNC Credentials & Azure Subscription

variable "username" {}
variable "password" {}
variable "url" {}
variable "subscription_id" {}


variable "tenant_name" {
  default = "dc1"
}

variable "vnet_aks_name" {
  default = "aks"
}

# AKS Service EPG

variable "aks_ap" {
  default = "aks-ap"
}

variable "aks_epg" {
  default = "aks-epg"
}

variable "aks_epg_selector" {
  default = "aks-epg-selector"
}

variable "aks_epg_ip_based" {
  default = "IP=='40.100.0.0/21'"
}

# Internet External EPG + Contract

variable "aks_internet" {
  default = "aks-internet"
}

variable "internet_selector_name" {
  default = "internet"
}

variable "internet_selector_subnet" {
  default = "0.0.0.0/0"
}

variable "internet_contract" {
  default = "aks-internet-access"
}

variable "aks_filter_name" {
  default = "internet-to-aks"
}  
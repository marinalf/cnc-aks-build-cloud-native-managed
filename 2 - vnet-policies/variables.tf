
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

variable "aks_ap" {
  default = "aks-ap"
}

# AKS Consumer EPG + Contract

variable "aks_consumer_epg" {
  default = "aks-consumer-epg"
}

variable "aks_consumer_selector" {
  default = "aks-consumer-epg-selector"
}

variable "aks_epg_ip_based" {
  default = "IP=='40.100.8.0/24'"
}

variable "internal_contract" {
  default = "aks-internal-access"
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

# Shared Filter

variable "aks_filter_name" {
  default = "internet-to-aks"
}  
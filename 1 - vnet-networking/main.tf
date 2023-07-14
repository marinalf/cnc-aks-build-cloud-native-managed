# VNet for AKS

resource "aci_vrf" "vnet_aks" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.vnet_aks_name
}

# Cloud Context Profile for AKS VNet + Subnets

resource "aci_cloud_context_profile" "ctx_vnet_aks" {
  tenant_dn                = data.aci_tenant.tenant1.id
  name                     = var.cxt_vnet_aks
  primary_cidr             = var.vnet_aks_cidr
  region                   = var.vnet_aks_region
  cloud_vendor             = var.cloud_vendor
  relation_cloud_rs_to_ctx = aci_vrf.vnet_aks.id
  hub_network              = "uni/tn-infra/gwrouterp-default" #VNet Peering is enabled by default
}

# Add Subnets for AKS VNet

resource "aci_cloud_subnet" "vnet_aks_subnets" {
  for_each           = var.vnet_aks_subnets
  cloud_cidr_pool_dn = data.aci_cloud_cidr_pool.vnet_aks_cidr.id
  name               = each.value.name
  ip                 = each.value.ip
}
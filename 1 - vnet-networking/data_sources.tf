
data "aci_tenant" "tenant1" {
  name = var.tenant_name
}

data "aci_cloud_cidr_pool" "vnet_aks_cidr" {
  cloud_context_profile_dn = aci_cloud_context_profile.ctx_vnet_aks.id
  addr                     = var.vnet_aks_cidr
}

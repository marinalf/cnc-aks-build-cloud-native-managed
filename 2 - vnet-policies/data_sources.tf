
data "aci_tenant" "tenant1" {
  name = var.tenant_name
}

data "aci_vrf" "vnet_aks" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.vnet_aks_name
}

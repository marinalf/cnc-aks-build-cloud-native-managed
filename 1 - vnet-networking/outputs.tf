# Outputs for AKS deployment

output "rg-name" {
  value = "${data.aci_tenant.tenant1.name}_${aci_vrf.vnet_aks.name}_${aci_cloud_context_profile.ctx_vnet_aks.region}"
}

output "vnet" {
  value = aci_vrf.vnet_aks.name
}

# Application Profile for Service EPG

resource "aci_cloud_applicationcontainer" "aks_ap" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.aks_ap
}

# Service EPG needs to be created via GUI or REST APIs
## https://github.com/CiscoDevNet/terraform-provider-aci/issues/1078

# AKS Consumer EPG

resource "aci_cloud_epg" "aks_consumer_epg" {
  name                            = var.aks_consumer_epg
  cloud_applicationcontainer_dn   = aci_cloud_applicationcontainer.aks_ap.id
  relation_fv_rs_cons             = [aci_contract.internal_access.id]
  relation_fv_rs_prov             = [aci_contract.internet_access.id]
  relation_cloud_rs_cloud_epg_ctx = data.aci_vrf.vnet_aks.id
}

resource "aci_cloud_endpoint_selector" "aks_consumer_epg_selector" {
  cloud_epg_dn     = aci_cloud_epg.aks_consumer_epg.id
  name             = var.aks_consumer_selector
  match_expression = var.aks_epg_ip_based
}

# Cloud External EPG for Internet Access

resource "aci_cloud_external_epg" "aks_internet" {
  name                            = var.aks_internet
  cloud_applicationcontainer_dn   = aci_cloud_applicationcontainer.aks_ap.id
  relation_fv_rs_cons             = [aci_contract.internet_access.id]
  relation_cloud_rs_cloud_epg_ctx = data.aci_vrf.vnet_aks.id
  route_reachability              = "internet"
}

resource "aci_cloud_endpoint_selectorfor_external_epgs" "internet_ext_epg_selector" {
  cloud_external_epg_dn = aci_cloud_external_epg.aks_internet.id
  name                  = var.internet_selector_name
  subnet                = var.internet_selector_subnet
}

# Contract for Internal Access

resource "aci_contract" "internal_access" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.internal_contract
}

resource "aci_contract_subject" "internal_access" {
  contract_dn                  = aci_contract.internal_access.id
  name                         = "internal-access"
  relation_vz_rs_subj_filt_att = [aci_filter.aks_access.id]
}

# Contract for Internet Access

resource "aci_contract" "internet_access" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.internet_contract
}

resource "aci_contract_subject" "internet_access" {
  contract_dn                  = aci_contract.internet_access.id
  name                         = "internet-access"
  relation_vz_rs_subj_filt_att = [aci_filter.aks_access.id]
}

# Shared filter for AKS access (internal and internet)

resource "aci_filter" "aks_access" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.aks_filter_name
}

resource "aci_filter_entry" "http" {
  name        = "http"
  filter_dn   = aci_filter.aks_access.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "80"
  d_to_port   = "80"
}

resource "aci_filter_entry" "ssh" {
  name        = "ssh"
  filter_dn   = aci_filter.aks_access.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "22"
  d_to_port   = "22"
}
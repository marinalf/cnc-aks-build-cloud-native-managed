# Application Profile for Service EPG

resource "aci_cloud_applicationcontainer" "aks_ap" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.aks_ap
}

# Service EPG needs to be created via GUI or REST APIs
## https://github.com/CiscoDevNet/terraform-provider-aci/issues/1078

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

# Contract for Internet Access

resource "aci_contract" "internet_access" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.internet_contract
  scope     = "tenant"
}

resource "aci_contract_subject" "internet_access" {
  contract_dn                  = aci_contract.internet_access.id
  name                         = "internet-access"
  relation_vz_rs_subj_filt_att = [aci_filter.internet_to_aks.id]
}

resource "aci_filter" "internet_to_aks" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.aks_filter_name
}

resource "aci_filter_entry" "http" {
  name        = "http"
  filter_dn   = aci_filter.internet_to_aks.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "80"
  d_to_port   = "80"
}
resource "apstra_property_set" "a" {
  name = format("%s management IPs", var.hostname)
  data = jsonencode({
    (format("%s_master_ip", var.hostname)) = var.master_ip
    (format("%s_re0_ip", var.hostname))    = var.re0_ip
    (format("%s_re1_ip", var.hostname))    = var.re1_ip
  })
}

resource "apstra_datacenter_property_set" "a" {
  blueprint_id      = var.blueprint_id
  id                = apstra_property_set.a.id
  sync_with_catalog = true
}
#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

locals {
  t = <<-EOT
    set system commit synchronize
    set groups re0 interfaces em1 unit 0 family inetaddress {{$${hostname}_re0_ip}}
    set groups re0 interfaces em1 unit 0 family inetaddress {{$${hostname}_master_ip}} master-only
    set groups re1 interfaces em1 unit 0 family inetaddress {{$${hostname}_re1_ip}}
    set groups re1 interfaces em1 unit 0 family inetaddress {{$${hostname}_master_ip}} master-only
    set chassis redundancy routing-engine 0 master
    set chassis redundancy routing-engine 1 backup
    set chassis redundancy failover on-loss-of-keepalives
    set chassis redundancy failover on-disk-failure
    set chassis redundancy graceful-switchover
  EOT
}

resource "apstra_datacenter_configlet" "example" {
  blueprint_id = var.blueprint_id
  condition    = format("hostname in [\"%s\"]", var.hostname)
  name         = format("%s dual RE", var.hostname)
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_set_delete"
      template_text = templatestring(local.t, { hostname = var.hostname })
    },
  ]
}

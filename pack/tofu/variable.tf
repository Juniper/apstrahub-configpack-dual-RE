#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "blueprint_id" {
  type = string
}

variable "hostname" {
  type = string
  description = "Hostname of device with dual routing engines"
}

variable "re0_ip" {
  type = string
  description = "IP address of routing engine 0"
}

variable "re1_ip" {
  type = string
  description = "IP address of routing engine 1"
}

variable "master_ip" {
  type = string
  description = "IP address of the active routing engine"
}

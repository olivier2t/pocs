# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

#
# ESXi
#
variable "esxi_hostname" {
  description = "Name of the ESXi"
  default     = "sd-150734."
}

variable "esxi_datacenter" {
  description = "Datacenter where to create the virtual machine"
  default     = "dc1"
}

variable "esxi_datastore" {
  description = "Datastore where to create the virtual machine"
  default     = "datastore1"
}

variable "esxi_datastore_iso" {
  description = "Datastore where ISOs are stored"
  default     = "datastore1"
}

variable "esxi_network" {
  description = "Network where to create the virtual machine"
  default     = "VM Network"
}


#
# VM
#

variable "vm_name" {
  description = "Name of the virtual machine"
  default     = "($ organization_canonical $)-($ project $)-($ environment $)-vm"
}

variable "vm_ip" {
  description = "IP address of the virtual machine"
  default     = "212.129.18.92"
}

variable "vm_mac" {
  description = "MAC address of the virtual machine"
  default     = "00:50:56:01:f1:96"
}

variable "vm_cpu" {
  description = "Number of vCPU allocated to the virtual machine"
  default     = "2"
}

variable "vm_memory" {
  description = "Memory allocated to the virtual machine (Mo)"
  default     = "2048"
}

variable "vm_disk_size" {
  description = "Disk size allocated to the virtual machine (Go)"
  default = "20"
}

variable "vm_iso" {
  description = "Path to ISO file needed to bootstrap the virtual machine."
  default = ""
}
data "vsphere_datacenter" "dc" {
  name = var.esxi_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.esxi_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "iso_datastore" {
  name          = var.esxi_datastore_iso
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.esxi_hostname}/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.esxi_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory

  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label     = "disk0" # Increase the number for each new disk
    size      = var.vm_disk_size
    disk_mode = "independent_nonpersistent"
  }

  cdrom {
    datastore_id = data.vsphere_datastore.iso_datastore.id
    path         = var.vm_iso
  }
  
}
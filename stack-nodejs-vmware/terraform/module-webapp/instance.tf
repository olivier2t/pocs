resource vsphere_virtual_machine "webapp" {
  name             = var.hostname
  resource_pool_id = data.vsphere_compute_cluster.this.resource_pool_id
  datastore_id     = data.vsphere_datastore.this.id

  num_cpus = 2
  memory   = 1024
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  cdrom {
    client_device = true
  }

  network_interface {
    network_id   = data.vsphere_network.this.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  wait_for_guest_net_timeout = 0

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  # Using vApp Properties when using OVF/OVA templates
  vapp {
    properties ={
      hostname = var.hostname
      user-data = base64encode(templatefile(
        "${path.module}/userdata.sh.tpl",
        {
          git_app_url = var.git_app_url
        }
      ))
    }
  }

  # Using extra_config Properties when cloning VM
  extra_config = {
    "guestinfo.userdata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile(
      "${path.module}/userdata.sh.tpl",
      {
        git_app_url = var.git_app_url
      }
    ))
  }
}
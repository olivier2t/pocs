resource vsphere_virtual_machine "vm" {
  name             = "${var.customer}-${var.project}-${var.env}-webapp"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false

  cdrom {
    client_device = true
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    use_static_mac = true
    mac_address = var.vm_mac
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk_size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  # Using vApp Properties when using OVF/OVA templates
  vapp {
    properties ={
      hostname = "${var.customer}-${var.project}-${var.env}-webapp"
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

  tags = [
    vsphere_tag.cycloid.id,
    vsphere_tag.role.id,
    vsphere_tag.project.id,
    vsphere_tag.env.id
  ]
}
module "webapp" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-webapp"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #
  # Web App
  #

  #. git_app_url: ''
  #+ Public git URL of the web application to build and deploy
  git_app_url = "Value injected by StackForms"


  #
  # vSphere
  #

  #. vsphere_datacenter (required,string): dc1
  #+ Datacenter where to create the virtual machine
  vsphere_datacenter = var.vsphere_env["datacenter"]

  #. vsphere_datastore (required,string): datastore1
  #+ Datastore where to create the virtual machine
  vsphere_datastore = var.vsphere_env["datastore"]

  #. vsphere_cluster (required,string): cluster1
  #+ Cluster where to create the virtual machine
  vsphere_cluster = var.vsphere_env["cluster"]

  #. vsphere_network (required,string): VM Network
  #+ Cluster where to create the virtual machine
  vsphere_network = "VM Network"


  #
  # VM
  #

  #. vsphere_template (required,string): debian-9
  #+ Virtual machine template
  vsphere_template = "Value injected by StackForms"

  #. vm_cpu (required,integer): 2
  #+ Number of CPU allocated to the virtual machine
  vm_cpu = "Value injected by StackForms"

  #. vm_memory (required,integer): 2048
  #+ Memory allocated to the virtual machine (Mo)
  vm_memory = "Value injected by StackForms"

  #. vm_disk_size (required,integer): 20
  #+ Disk size allocated to the virtual machine (Go)
  vm_disk_size = "Value injected by StackForms"

  #. vm_ip (required,string): "212.129.18.92"
  #+ IP address of the virtual machine
  vm_ip = "Value injected by StackForms"

  #. vm_mac (required,string): "00:50:56:01:f1:96"
  #+ IP address of the virtual machine
  vm_mac = "Value injected by StackForms"

}

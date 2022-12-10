resource "vsphere_tag_category" "category" {
  name = "${var.customer}-${var.project}-${var.env}"
  cardinality = "MULTIPLE"

  associable_types = [
    "VirtualMachine",
    "Datastore",
  ]
}
 
resource "vsphere_tag" "cycloid" {
  name        = "tag_cycloid_true"
  category_id = vsphere_tag_category.category.id
}

resource "vsphere_tag" "role" {
  name        = "tag_role_nexus"
  category_id = vsphere_tag_category.category.id
}

resource "vsphere_tag" "project" {
  name        = "tag_project_${var.project}"
  category_id = vsphere_tag_category.category.id
}

resource "vsphere_tag" "env" {
  name        = "tag_env_${var.env}"
  category_id = vsphere_tag_category.category.id
}
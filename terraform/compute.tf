resource "oci_core_instance" "Test-instance" {
  #Required parameters
  availability_domain = "gZwj:AF-JOHANNESBURG-1-AD-1"
  compartment_id      = var.compartment_id
  shape               = var.vm_instance_shape
  display_name        = "OCI-Instance-Test-instance"

  create_vnic_details {
    subnet_id        = oci_core_subnet.Test-network-subnet.id
    assign_public_ip = true
  }
  #Optional parameters
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.instance_image.images[0].id  # Not a string value
  }
  metadata = {
    ssh_authorized_keys = var.ssh_key_path
  }
  freeform_tags = { "Test-Project" = "Create Instance in OCI" }

}
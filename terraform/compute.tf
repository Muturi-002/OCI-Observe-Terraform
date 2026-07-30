resource "oci_core_instance" "Test-instance" {
  #Required parameters
  availability_domain = "gZwj:AF-JOHANNESBURG-1-AD-1"
  compartment_id      = module.identity.observability_compartment_id #specified compartment specifically for this project.
  shape               = var.vm_instance_shape
  display_name        = "Observed_Instance" # Instance name changed for purpose of notification topic change.

  create_vnic_details {
    subnet_id        = oci_core_subnet.Test-network-subnet.id
    assign_public_ip = true
  }
  #Optional parameters
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.instance_image.images[0].id # Not a string value
  }
  metadata = {
    ssh_authorized_keys = var.ssh_key_path
    user_data           = base64encode(file("./cloud-init.sh"))
  }
  freeform_tags = { "Test-Project" = "Create Instance in OCI" }

}
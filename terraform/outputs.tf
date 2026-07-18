output "available_images" {
  description = "List of available OCI images for the selected operating system"
  value = {
    for image in data.oci_core_images.instance_image.images : image.display_name => image.id
  }
}

output "Instance_ip" {
  description = "Public IPv4 address of the instance"
  value       = oci_core_instance.Test-instance.public_ip
}
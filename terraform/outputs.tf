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

output "instance_ocid" {
  description = "OCID of instance created."
  value       = oci_core_instance.Test-instance.id
}

output "object_storage_bucket" {
  description = "Name of the bucket"
  value       = oci_objectstorage_bucket.backend_bucket.name
}
output "bucket_objects" {
  description = "Names of objects in the dedicated bucket"
  value       = [for object in data.oci_objectstorage_objects.backend_bucket_objects.objects : object.name]
}
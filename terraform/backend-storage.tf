# Create the OCI OS bucket
resource "oci_objectstorage_bucket" "backend_bucket" {
  compartment_id = module.identity.observability_compartment_id
  name           = "Terraform-state-bucket"
  namespace      = var.objectstorage_namespace

  versioning = "Enabled"
}

# Get list of objects
data "oci_objectstorage_objects" "backend_bucket_objects" {
  bucket    = oci_objectstorage_bucket.backend_bucket.name
  namespace = var.objectstorage_namespace
}

# Set the backend for remote state management
terraform {
  backend "oci" {
    bucket    = "Terraform-state-bucket"                    # bucket name
    namespace = "<object_storage_namespace>"                # object storage namespace
  }
}
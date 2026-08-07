# Create the OCI OS bucket
resource "oci_objectstorage_bucket" "backend_bucket" {
  compartment_id = module.identity.observability_compartment_id
  name           = "Terraform-state-bucket"
  namespace      = var.objectstorage_namespace

  versioning = "Enabled"
}

# Set the backend for remote state management
terraform {
  backend "oci" {
    bucket    = "Terraform-state-bucket"     # bucket name
    namespace = "<object_storage_namespace>" # object storage namespace
  }
}
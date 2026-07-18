terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.20.0"
    }
  }
}
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.path_to_key_file
  region           = var.tenancy_region
}
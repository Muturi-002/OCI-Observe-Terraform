# Acquire configuration for IAM. Requires newer file for easier modification
module "identity" {
  source = "./identity"

  # Compartment definition
  compartment_id = var.compartment_id
  name           = "Infra-observe"

  # Region definition
  region = var.tenancy_region

  # User Group definition
  tenancy_ocid = var.tenancy_ocid

  # Username definition
  user_name  = var.observability_user
  user_email = var.user_email
}

module "observability" {
  source = "./Observability-config"

  compartment_id = var.compartment_id
  region         = var.tenancy_region
  tenancy_ocid   = var.tenancy_ocid

  observability_compartment_id = module.identity.observability_compartment_id
  observability_user_email     = module.identity.user_email
  instance_id                  = oci_core_instance.Test-instance.id
  instance_name                = oci_core_instance.Test-instance.display_name
}


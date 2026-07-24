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

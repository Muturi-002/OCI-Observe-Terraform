output "observability_compartment_id" {
  description = "OCID of the observability compartment created by the identity module."
  value       = oci_identity_compartment.observability_compartment.id
}

output "user_email" {
  description = "user email used for this demo"
  value       = var.user_email
}
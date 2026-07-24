output "observability_compartment_id" {
  description = "OCID of the observability compartment created by the identity module."
  value       = oci_identity_compartment.observability_compartment.id
}

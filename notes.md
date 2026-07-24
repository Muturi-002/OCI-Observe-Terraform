# Notes

## Module configuration
If you need to export values between modules, create an output file for the specific values. Consider the following files: `./terraform/compute.tf`, `./terraform/identity/iam.tf` and `./terraform/identity/outputs.tf`.
`compute.tf`
```hcl
resource "oci_core_instance" "Test_instance" {
    # line(s) of code
    compartment_id      = module.identity.observability_compartment_id #specified compartment specifically for this project.
    # Line(s) of code
}
```
`iam.tf`
```hcl
resource "oci_identity_compartment" "observability_compartment" {
  #Required
  compartment_id = var.compartment_id
  description    = "Compartment for isolated observability operations"

  name = "Infra-observe"

}
```
`identity/outputs.tf`
```hcl
output "observability_compartment_id" {
  description = "OCID of the observability compartment created by the identity module."
  value       = oci_identity_compartment.observability_compartment.id
}
```

The output file declares the OCID for the newly created compartment, whic is to be exported by Terraform module `identity` in the file `./modules.tf`. Running the command `terraform plan` ensures that the value is first exported before any provisioning is made.


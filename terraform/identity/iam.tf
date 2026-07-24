# Compartment creation
resource "oci_identity_compartment" "observability_compartment" {
  #Required
  compartment_id = var.compartment_id
  description    = "Compartment for isolated observability operations"

  name = "Infra-observe"

}

# Identity Management
/*
Creating a user group tied to this compartment
*/
resource "oci_identity_group" "observability_group" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = "User group for the compartment use"
  name           = "Group-Observe"
}
/*
New user for this compartment
*/
resource "oci_identity_user" "observability_user" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = "User created specifically for this compartment"
  name           = var.user_name
  email          = var.user_email # Has to be specified
}
/*
Associate user with group
*/
resource "oci_identity_user_group_membership" "test_user_group_membership" {
  #Required
  group_id = oci_identity_group.observability_group.id
  user_id  = oci_identity_user.observability_user.id
}

/*
Create policy on compartment
*/
resource "oci_identity_policy" "test_policy" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = "Policies governing use of the observability compartment. Defining read and use permissions of this user."
  name           = "Observability-compartment-dedicated-user-permissions"
  statements = [
    # Allow usage permissions on all resources under the observability compartment
    "Allow group ${oci_identity_group.observability_group.name} to use instance-family in compartment ${oci_identity_compartment.observability_compartment.name}",
    "Allow group ${oci_identity_group.observability_group.name} to use virtual-network-family in compartment ${oci_identity_compartment.observability_compartment.name}",

    # Allow monitoring capabilities for the dedicated user under the observability compartment
    "Allow group ${oci_identity_group.observability_group.name} to manage alarms in compartment ${oci_identity_compartment.observability_compartment.name}", # User needs to create alarms in this compartment. Assuming a production-level scenario
    "Allow group ${oci_identity_group.observability_group.name} to use metrics in compartment ${oci_identity_compartment.observability_compartment.name}"
  ]
}
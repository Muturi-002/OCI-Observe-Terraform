variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "path_to_key_file" {}
variable "tenancy_region" {}
variable "compartment_id" {
  description = "The OCID of the parent compartment where resources will be created."
}
variable "ssh_key_path" {
  description = "The SSH private key to be used for connecting to the instance(s)."
}
variable "vm_instance_shape" {}

variable "vm_instance_OS" {
  description = "desired OS for the VM"
}
variable "image_OS_version" {
  description = "Version of OS to be used e.g., for Canonical Ubuntu, 20.04, 22.04 e.t.c."
}

# Networking variables
variable "vcn_cidr_blocks" {
  description = "CIDR blocks for the network created using this terraform script"
  type        = list(string)
  default     = ["172.16.0.0/20"]
}

variable "dns_label" {
  description = "The DNS label for the VCN."
  type        = string
  default     = "testdns"
}

# Define Observability compartment user
variable "observability_user" {
  description = "username of the observability compartment"
  type        = string
}

variable "user_email" {
  description = "user email"
  type        = string
}

# Object Storage configs
variable "objectstorage_namespace" {
  description = "namespace of the OCI object storage in your tenancy."
}
variable "backend_bucket_id" {
  description = "Object storage bucket used for remote state configuration management"
}
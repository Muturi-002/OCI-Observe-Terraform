variable "compartment_id" {
  description = "The OCID of the parent compartment."
  type        = string
}

variable "name" {
  description = "Name of the compartment to create."
  type        = string
}


variable "region" {
  description = "Home region of tenancy"
}

variable "tenancy_ocid" {
  description = "tenancy region of the user group"
}

variable "user_name" {
  description = "Username for observability compartment use."
}

variable "user_email" {
  description = "user's email"
}
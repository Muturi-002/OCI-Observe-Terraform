resource "oci_core_vcn" "Test-network" {
  compartment_id = module.identity.observability_compartment_id
  cidr_blocks    = var.vcn_cidr_blocks
  dns_label      = var.dns_label
  display_name   = var.dns_label
}

resource "oci_core_internet_gateway" "Test-network-igw" {
  compartment_id = module.identity.observability_compartment_id
  vcn_id         = oci_core_vcn.Test-network.id
  display_name   = "OCI-IGW-Test-network1"
}

resource "oci_core_route_table" "Test-network-rt" {
  compartment_id = module.identity.observability_compartment_id
  vcn_id         = oci_core_vcn.Test-network.id
  display_name   = "OCI-RT-Test-network1"
  route_rules {
    network_entity_id = oci_core_internet_gateway.Test-network-igw.id
    destination       = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "Test-network-subnet" {
  compartment_id = module.identity.observability_compartment_id
  vcn_id         = oci_core_vcn.Test-network.id
  cidr_block     = var.vcn_cidr_blocks[0]
  dns_label      = var.dns_label
  route_table_id = oci_core_route_table.Test-network-rt.id
  display_name   = "OCI-Subnet-Test-network1"
}

resource "oci_core_network_security_group" "Test-network-NSG" {
  compartment_id = module.identity.observability_compartment_id
  vcn_id         = oci_core_vcn.Test-network.id
  display_name   = "Test-network-NSG"
}

resource "oci_core_network_security_group_security_rule" "allow_ssh" {
  network_security_group_id = oci_core_network_security_group.Test-network-NSG.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "allow_http" {
  network_security_group_id = oci_core_network_security_group.Test-network-NSG.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}

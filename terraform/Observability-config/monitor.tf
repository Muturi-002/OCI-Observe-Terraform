data "oci_monitoring_metrics" "server_metrics" {
  compartment_id = var.observability_compartment_id

  dimension_filters = {
    "resourceId" : var.instance_id
  }
  name      = "CpuUtilization"
  namespace = "oci_computeagent"
}


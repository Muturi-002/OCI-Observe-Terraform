data "oci_monitoring_metrics" "server_metrics" {
  #Required
  compartment_id = var.compartment_id

  dimension_filters = {
    "resourceId" : "${oci_compute_instance.Test_instance.id}"
  }
  name      = "CPU Utilization"
  namespace = "oci_computeagent"
}
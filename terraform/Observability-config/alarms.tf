resource "oci_monitoring_alarm" "test_alarm" {
  #Required
  compartment_id        = var.observability_compartment_id
  destinations          = [oci_ons_notification_topic.notify_topic.id]
  display_name          = "CPU Threshhold reached"
  is_enabled            = true
  metric_compartment_id = var.observability_compartment_id
  namespace             = data.oci_monitoring_metrics.server_metrics.namespace
  query                 = var.alarm_query
  severity              = var.alarm_severity[0]

  #Optional
  alarm_summary      = "CPU Utilization: ${var.metric_threshhold}% used"
  body               = "The CPU has hit a usage of ${var.metric_threshhold}% during production. This is a test metric; no cause of alarm"
  message_format     = var.alarm_message_body_format[1]
  notification_title = oci_ons_notification_topic.notify_topic.name
}

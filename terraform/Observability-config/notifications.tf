resource "oci_ons_notification_topic" "notify_topic" {
  #Required
  compartment_id = var.observability_compartment_id
  name           = "observe_${var.instance_name}"

}

resource "oci_ons_subscription" "test_subscription" {
  #Required
  compartment_id = var.observability_compartment_id
  endpoint       = var.observability_user_email
  protocol       = "EMAIL"
  topic_id       = oci_ons_notification_topic.notify_topic.id

}
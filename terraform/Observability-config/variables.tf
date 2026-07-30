variable "compartment_id" {
  description = "The OCID of the parent compartment."
  type        = string
}
variable "region" {
  description = "Home region of tenancy"
}

variable "tenancy_ocid" {
  description = "Tenancy OCID for the user group"
  type        = string
}

variable "observability_compartment_id" {
  description = "The compartment OCID where observability resources will be created."
  type        = string
}

variable "observability_user_email" {
  description = "Email address for the observability user notifications."
  type        = string
}

variable "instance_id" {
  description = "OCID of the compute instance to monitor."
  type        = string
}

variable "instance_name" {
  description = "Display name of the compute instance to monitor."
  type        = string
}

variable "notification_topic_name" {
  description = "Name to assign to the notification topic."
  type        = string
  default     = null
}

# Variables for the monitoring service
variable "alarm_severity" {
  description = "Level of severity on the alarm triggered"
  type        = list(string)
  default     = ["CRITICAL", "INFO", "WARNING", "ERROR"]
}
variable "alarm_query" {
  description = "Query determining level of concern to be raised by the alarm"
  default     = "CpuUtilization[1m].mean() >= 50"
}
variable "metric_threshhold" {
  description = "Determine the CPU utilization level needed for an alarm to be triggered"
  type        = number
  default     = 50
}
variable "alarm_message_body_format" {
  description="Body format of the alarm message"
  type=list(string)
  default=["RAW", "PRETTY_JSON", "ONS_OPTIMIZED"]
}
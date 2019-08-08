# System variables
variable "aws_region" {
  type        = "string"
  description = "Region of AWS Account"
  default     = "eu-west-1"
}

variable "aws_cli_profile" {
  type        = "string"
  description = "CLI Profile used for AWS"
  default     = "default"
}

variable "dd_api_key" {
  type        = "string"
  description = "API Key Retreived from Datadog"
  default     = ""
}

variable "dd_app_key" {
  type        = "string"
  description = "APP Key Retreived from Datadog"
  default     = ""
}

variable "pagerduty_token" {
  type        = "string"
  description = "PagerDuty Token"
  default     = ""
}

variable "slack_webhook_url" {
  type        = "string"
  description = "Slack Webhook URL"
  default     = ""
}



## Product Variables

variable "dd_widget_width_small" {
  description = "The width of the DataDog widget (small)"
  default = 23
}

variable "dd_widget_width_large" {
  description = "The width of the DataDog widget (large)"
  default = 47
}

variable "dd_widget_height" {
  description = "The width of the DataDog widget"
  default = 13
}

variable "ec2-api-host-name" {
  type        = "string"
  description = "API HostName"
  default = "*"
}

variable "ecs-api-name" {
  type        = "string"
  description = "ECS API Name"
  default = "*"
}
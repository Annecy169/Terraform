# Create a PagerDuty team
resource "pagerduty_team" "autodots" {
  name        = "autodots"
  description = "The DevOps Team"
}

# Create a PagerDuty user
resource "pagerduty_user" "watto" {
  name  = "Alex Watson"
  email = "alex.w@mmtdigital.co.uk"
  teams = ["${pagerduty_team.autodots.id}"]
}

data "pagerduty_user" "xander" {
  email = "alex.t@mmtdigital.co.uk"
}

data "pagerduty_extension_schema" "slack-webhook" {
  name = "Generic V2 Webhook"
}

resource "pagerduty_schedule" "devops" {
  name      = "DevOps Rotation"
  time_zone = "Europe/London"

  layer {
    name                         = "24/7 Shift"
    start                        = "2019-08-08T00:00:00-05:00"
    rotation_virtual_start       = "2019-08-08T00:00:00-05:00"
    rotation_turn_length_seconds = 43200
    users                        = ["${pagerduty_user.watto.id}", "${data.pagerduty_user.xander.id}"]
  }
}

resource "pagerduty_escalation_policy" "devops" {
  name      = "DevOps Escalation Policy"
  num_loops = 2
  teams     = ["${pagerduty_team.autodots.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule"
      id   = "${pagerduty_schedule.devops.id}"
    }
  }

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "user"
      id   = "${pagerduty_user.watto.id}"
    }

    target {
      type = "user"
      id   = "${data.pagerduty_user.xander.id}"
    }
  }
}

resource "pagerduty_service" "devops" {
  name                    = "DevOps"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.devops.id}"
}

resource "pagerduty_extension" "slack"{
  name = "DevOps Extension"
  endpoint_url = "${var.slack_webhook_url}"
  extension_schema = "${data.pagerduty_extension_schema.slack-webhook.id}"
  extension_objects    = ["${pagerduty_service.devops.id}"]

  config = <<EOF
{
    "restrict": "any",
    "notify_types": {
            "resolve": true,
            "acknowledge": true,
            "assignments": true
    }
}
EOF

}

data "pagerduty_vendor" "cloudwatch" {
  name = "Cloudwatch"
}

resource "pagerduty_service_integration" "cloudwatch" {
  name    = "${data.pagerduty_vendor.cloudwatch.name}"
  service = "${pagerduty_service.devops.id}"
  vendor  = "${data.pagerduty_vendor.cloudwatch.id}"
}
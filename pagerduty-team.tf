# Create a PagerDuty team
resource "pagerduty_team" "autodots" {
  name        = "autodots"
  description = "The DevOps Team"
}

# Create a PagerDuty user
resource "pagerduty_user" "earline" {
  name  = "Alex Watson"
  email = "alex.w@mmtdigital.co.uk"
  teams = ["${pagerduty_team.autodots.id}"]
}
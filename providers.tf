terraform {
  required_version = ">= 0.12.3"
}

provider "aws" {
  version = "2.17"
  region  = "${var.aws_region}"
  profile = "${var.aws_cli_profile}"
}

provider "datadog" {
  version = "2.0"
  api_key = "${var.dd_api_key}"
  app_key = "${var.dd_app_key}"
}

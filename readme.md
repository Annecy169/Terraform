# Edit all Variables in the following areas
The backend file [backend.tf](backend.tf)
The variable file [prod.tfvars](prod.tvars)

## Running Terraform Locally
When you run Terraform locally make sure you are in the correct folder location and run
```terraform apply -var-file="prod.tfvars"```

## Resources
    PagerDuty Terraform - https://www.terraform.io/docs/providers/pagerduty/
    DataDog Terraform   - https://www.terraform.io/docs/providers/datadog/index.html
# Azure Resource Tagging Policy

## Purpose
Standardize tagging across all Azure resources
for cost attribution, compliance and governance.

## Mandatory Tags — ALL Resources

| Tag | Values | Example |
|-----|--------|---------|
| environment | dev/staging/prod | prod |
| team | platform/ml/data | platform |
| project | project name | databricks-platform |
| owner | team email | platform@company.com |
| cost-center | code | CC-1234 |

## Resources Tagged
- Resource Groups
- Databricks Workspace
- Storage Accounts (ADLS Gen2)
- Virtual Network + Subnets
- Key Vault
- Private Endpoints
- Network Security Groups

## Tagging via Terraform
All resources provisioned via Terraform include
mandatory tags through a common tags variable.

```hcl
locals {
  common_tags = {
    environment = var.environment
    team        = "platform-engineering"
    project     = "databricks-platform"
    owner       = var.owner_email
    cost-center = var.cost_center
  }
}
```

## Enforcement
- Azure Policy applied at subscription level
- Non-compliant resources flagged automatically
- Terraform validates tags before apply

## Gotchas
| Issue | Fix |
|-------|-----|
|       |     |

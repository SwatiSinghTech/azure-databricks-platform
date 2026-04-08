## Databricks Data Governance — Unity Catalog

## Overview
Enterprise data governance framework implemented
via Unity Catalog for Azure Databricks platform.

---

# Unity Catalog Governance Setup

## Catalog Structure
prod-catalog/
├── raw-schema/          ← ingestion layer
├── curated-schema/      ← processed/cleaned
├── ml-schema/           ← feature store + ML
└── reporting-schema/    ← BI + reporting

## Data Classification Policy

### Sensitivity Levels
| Classification | Description | Examples |
|---------------|-------------|---------|
| PUBLIC | Non-sensitive, open data | Product names, public metrics |
| INTERNAL | Internal use only | Business KPIs, reports |
| CONFIDENTIAL | Restricted access | Financial data, contracts |
| PII | Personal Identifiable Info | Name, email, address, phone |
| PHI | Personal Health Information | Medical records, diagnosis |
| FINANCIAL | Financial sensitive data | Salary, bank details, revenue |
| SECRET | Highest restriction | Auth tokens, encryption keys |

---

## Column Level Tagging

### PII Tags
| Tag | Applied To |
|-----|-----------|
| pii-name | Full name columns |
| pii-email | Email address columns |
| pii-phone | Phone number columns |
| pii-address | Physical address columns |
| pii-dob | Date of birth columns |
| pii-ssn | Social security number |
| pii-ip | IP address columns |

### PHI Tags
| Tag | Applied To |
|-----|-----------|
| phi-diagnosis | Medical diagnosis |
| phi-medication | Medication details |
| phi-records | Health records |

### Financial Tags
| Tag | Applied To |
|-----|-----------|
| financial-salary | Salary/compensation |
| financial-bank | Bank account details |
| financial-revenue | Revenue/profit data |
| financial-tax | Tax related data |

### Confidential Tags
| Tag | Applied To |
|-----|-----------|
| confidential-contract | Contract details |
| confidential-strategy | Business strategy |
| confidential-legal | Legal documents |

---

## Table Level Tagging
| Tag | Values |
|-----|--------|
| sensitivity | public/internal/confidential/pii/phi/financial |
| domain | ml/finance/marketing/operations |
| status | active/deprecated/archived |
| owner | team name |

---

## Schema Level Tagging
| Tag | Values |
|-----|--------|
| environment | dev/staging/prod |
| domain | ml/finance/marketing |
| data-tier | raw/curated/reporting |

---

## Access Control Matrix

| Role | Raw Schema | Curated Schema | ML Schema | Reporting |
|------|-----------|----------------|-----------|-----------|
| platform-admin | ALL | ALL | ALL | ALL |
| ml-engineers | READ | READ | ALL | READ |
| data-engineers | ALL | ALL | READ | READ |
| analysts | NONE | READ | NONE | ALL |
| bi-team | NONE | READ | NONE | ALL |

---

## Column Masking Rules
PII and PHI columns automatically masked
for non-privileged users:

```sql
-- Email masking for non-PII roles
CASE 
  WHEN is_member('pii-access-group') 
  THEN email
  ELSE regexp_replace(email, '(^[^@]+)', '****')
END
```

---

## Row Level Security
Sensitive rows filtered based on user group:
- Financial data → finance-team only
- PHI data → phi-access-group only
- Regional data → region-specific groups

---

## Audit Logging
All data access logged to:
- Azure Monitor
- QRadar (via Event Hub)

Logged events:
- Table access
- Column access on PII/PHI
- Permission changes
- Failed access attempts

---

## Gotchas
| Issue | Root Cause | Fix |
|-------|-----------|-----|
|       |           |     |

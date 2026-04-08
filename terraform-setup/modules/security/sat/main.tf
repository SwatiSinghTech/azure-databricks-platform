# SAT — Security Analysis Tool
# Deployed as scheduled Databricks Job

resource "databricks_job" "sat_scan" {
  name = "security-analysis-tool-${var.environment}"

  task {
    task_key = "sat_run"
    notebook_task {
      notebook_path = "/SAT/notebooks/sat_run"
    }
    existing_cluster_id = var.cluster_id
  }

  schedule {
    quartz_cron_expression = "0 0 8 * * ?"
    timezone_id            = "Asia/Kolkata"
  }

  email_notifications {
    on_failure = [var.alert_email]
  }

  tags = {
    environment = var.environment
    team        = "platform-engineering"
    tool        = "SAT"
  }
}

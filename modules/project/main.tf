resource "snowflake_database" "db" {
  name    = upper(var.project_name)
  comment = "Database for ${var.project_name} project"
}

resource "snowflake_warehouse" "wh" {
  name                = "WH_${upper(var.project_name)}"
  warehouse_size      = "XSMALL"
  auto_suspend        = 300
  auto_resume         = true
  initially_suspended = true
  comment             = "Warehouse for ${var.project_name}"
}

resource "snowflake_account_role" "role" {
  name    = "R_USERS_${upper(var.project_name)}"
  comment = "Role for ${var.project_name} users"
}

resource "snowflake_grant_privileges_to_account_role" "db_usage" {
  account_role_name = snowflake_account_role.role.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "schema_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.role.name

  on_schema {
    schema_name = "${snowflake_database.db.name}.PUBLIC"
  }
}

resource "snowflake_grant_privileges_to_account_role" "wh_usage" {
  account_role_name = snowflake_account_role.role.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.wh.name
  }
}

resource "snowflake_user" "user" {
  name                 = upper(var.project_name)
  password             = var.user_password
  default_role         = snowflake_account_role.role.name
  default_warehouse    = snowflake_warehouse.wh.name
  default_namespace    = "${snowflake_database.db.name}.PUBLIC"
  must_change_password = true
}

resource "snowflake_grant_account_role" "assign_role_to_user" {
  role_name = snowflake_account_role.role.name
  user_name = snowflake_user.user.name
}

resource "snowflake_grant_account_role" "grant_accountadmin" {
  role_name = "ACCOUNTADMIN"
  user_name = snowflake_user.user.name
}

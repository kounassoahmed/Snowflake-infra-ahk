terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = ">= 1.0.0"
    }
  }
}

provider "snowflake" {
  alias               = "main"
  account_name        = var.snowflake_account_name
  organization_name   = var.snowflake_organization_name
  user                = var.snowflake_username
  role                = var.snowflake_account_role
  authenticator       = var.snowflake_account_authenticator
  private_key         = file(var.private_key_path)
}

module "project" {

  for_each      = var.projects
  source        = "./modules/project"
  project_name  = each.key
  user_password = each.value.user_password

  providers = {
    snowflake = snowflake.main
  }
}


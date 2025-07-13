# terraform/main.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.54.0"
    }
  }
}

provider "snowflake" {
  account          = var.snowflake_account
  username         = var.snowflake_admin_user
  private_key_path = var.snowflake_private_key_path
  region           = var.snowflake_region        # ex: "eu-west-1"
  role             = var.snowflake_admin_role    # ex: "SECURITYADMIN"
}

resource "snowflake_user" "ahmedkounassopro" {
  name                 = "AHMEDKOUNASSOPRO"
  login_name           = "ahmedkounassopro"
  password             = "Strongpassword123+"
  default_role         = "ACCOUNTADMIN"
  must_change_password = true
}

resource "snowflake_role_grant" "grant_accountadmin_to_ahmed" {
  role_name = "ACCOUNTADMIN"
  users     = [snowflake_user.ahmedkounassopro.name]
}

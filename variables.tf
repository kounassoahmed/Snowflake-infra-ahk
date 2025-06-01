variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "snowflake_account_name" {
  type        = string
  description = "Snowflake account name"
}

variable "snowflake_organization_name" {
  type        = string
  description = "Snowflake org name"
}

variable "snowflake_username" {
  type        = string
  description = "Snowflake service account username"
}

variable "snowflake_account_role" {
  type = string
}

variable "snowflake_account_authenticator" {
  type = string
}

variable "private_key_path" {
  type        = string
  description = "Absolute path to Snowflake private key"
}

variable "projects" {
  type = map(object({
    user_password = string
  }))
  sensitive = false
}



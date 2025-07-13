# terraform/variables.tf
variable "snowflake_account" {
  description = "Snowflake account identifier (e.g. xy12345.eu-west-1)"
  type        = string
}

variable "snowflake_admin_user" {
  description = "User with rights to manage users (e.g. SECURITYADMIN)"
  type        = string
}

variable "snowflake_private_key_path" {
  description = "Path to the private key (.p8) for authentication"
  type        = string
}

variable "snowflake_region" {
  description = "Snowflake region"
  type        = string
  default     = "eu-west-1"
}

variable "snowflake_admin_role" {
  description = "Role to assume when running Terraform"
  type        = string
  default     = "SECURITYADMIN"
}

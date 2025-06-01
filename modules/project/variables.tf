variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "user_password" {
  type      = string
  sensitive = true
}

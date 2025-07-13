# users.tf

# Crée l’utilisateur ahmedkounassopro
resource "snowflake_user" "ahmedkounassopro" {
  provider            = snowflake.main
  name                = "AHMEDKOUNASSOPRO"
  login_name          = "ahmedkounassopro"
  password            = "Strongpassword123+"
  default_role        = "ACCOUNTADMIN"
  must_change_password = true
}

# Accorde le rôle ACCOUNTADMIN
resource "snowflake_role_grant" "ahmedkounassopro_accountadmin" {
  provider  = snowflake.main
  role_name = "ACCOUNTADMIN"
  users     = [snowflake_user.ahmedkounassopro.name]
}

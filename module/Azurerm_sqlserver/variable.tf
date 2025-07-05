variable "sql_server_name" {
    description = "the name of sql server "
    type = string  
}
variable "resource_group_name" {
    description = "name of resource group"
    type = string
}
variable"location"{
    description = "name of location"
    type = string 
}
variable "administrator_login" {
    description = "the administrator login for the sql server"
    type = string
}
variable "administrator_login_password" {
    description = "The Administrator login password"
    type = string
    sensitive = true

}
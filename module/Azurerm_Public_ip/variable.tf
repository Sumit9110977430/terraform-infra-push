variable "resource_group_name" {
    description = "name of resorce group"
    type = string
}
variable "public_ip_name" {
    description = "name of public ip"
    type = string
}
variable "location" {
    description = "location name "
    type = string  
}
variable "allocation_method" {
    description = "allocation method name "
  type = string
  default = "Static"
}


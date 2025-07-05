variable"virtual_network_name"{
    description = "name of the virtual network"
    type = string
}
variable "virtual_network_location" {
    description = "location name of virtuak network"
    type = string
}
variable "resource_group_name" {
    description = "name of theresorce group"
    type = string
}
variable"address_space"{
    description = "the address sapce of the virtual machine"
    type = list(string)
}
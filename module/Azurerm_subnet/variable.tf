variable"resource_group_name"{
    description = "the name of resorce group where subbnet is created"
    type = string 
}
variable"virtual_network_name"{
    description = "the name of virtual network where subnet is created "
    type = string
}
variable"subnet_name"{
    description = "name of the subnet"
    type = string 
}

variable"address_prefixes"{

description= "the address perfix of the subnet"
type = list(string) 
}


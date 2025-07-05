module"resource_group"{
    source = "../module/azurerm_resourcegroup"
    resource_group_name = "titurg"
    resource_group_location = "centralindia"
}
module "virtual_network" {
    depends_on = [ module.resource_group ]
    source = "../module/azurerm_virtualnetwork"
    virtual_network_name = "tituvirtualnetwork"
    virtual_network_location = "centralindia"
    resource_group_name = "titurg"
    address_space = ["10.0.0.0/16"]
}
module"frontend_subnet"{
    depends_on = [ module.virtual_network ]
    source = "../module/Azurerm_subnet"
    resource_group_name = "titurg"
    virtual_network_name = "tituvnet"
    subnet_name = "frontendsubnet"
    address_prefixes = ["10.0.1.0/24"]
}
module"backend_subnet"{
    depends_on = [ module.virtual_network ]
    source = "../module/Azurerm_subnet"
    resource_group_name = "titurg"
    virtual_network_name = "tituvnet"
    subnet_name = "backendsubnet"
    address_prefixes = ["10.0.1.0/24"]
}
module "public_ip" {
    source = "../module/Azurerm_Public_ip"
    public_ip_name = "titupublic_ip"
    resource_group_name = "titurg"
    location = "centralindia"
    allocation_method = "Static"

}
module "key_vault" {
    source = "../module/Azurerm_key_vault"
    key_vault_name= "titukeyvault"
    location= "centralindia"
    resource_group_name = "titurg"
}
module "vm_password" {
  source              = "../module/azurerm_key_vault_secret"
  depends_on          = [module.key_vault]
  key_vault_name      = "sonamkitijori"
  resource_group_name = "titurg"
  secret_name         = "vm-password"
  secret_value        = "P@ssw01rd@123"
}
module "vm_username" {
  source              = "../module/azurerm_key_vault_secret"
  depends_on          = [module.key_vault]
  key_vault_name      = "titukeyvault"
  resource_group_name = "titurg"
  secret_name         = "vm-username"
  secret_value        = "devopsadmin"
}
module "vm" {
  depends_on = [module.frontend_subnet, module.key_vault, module.vm_username, module.vm_password, module.public_ip]
  source     = "../modules/azurerm_virtual_machine"

  resource_group_name  = "titurg"
  location             = "centralindia"
  vm_name              = "tituvm"
  vm_size              = "Standard_B1s"
  admin_username       = "devopsadmin"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "titunic"
  frontend_ip_name     = "pip-todoapp-frontend"
  vnet_name            = "tituvnet"
  frontend_subnet_name = "frontend-subnet"
  key_vault_name       = "titukeyvault"
  username_secret_name = "vm-username"
  password_secret_name = "vm-password"
}
 module "sqlserver" {
   source              = "../module/azurerm_sqlserver"
   sql_server_name     = "titusqlserver008"
   resource_group_name = "titurg"
   location            = "centralindia"
   # secret ko rakhne ka sudhar - Azure Key Vault
   administrator_login          = "sqladmin"
   administrator_login_password = "P@ssw0rd1234!"
 }

 module "sql_database" {
   depends_on          = [module.sqlserver]
   source              = "../module/azurerm_sqldatabase"
   sql_server_name     = "todosqlserver008"
   resource_group_name = "titurg"
   sql_database_name   = "titusqldatabase"
 }

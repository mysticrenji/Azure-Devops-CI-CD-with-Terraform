provider "azurerm" { 
} 
terraform { 
 backend "azurerm" {}
} 

resource "azurerm_resource_group" "dev" {
  name     = "__appresourcegroup__"
  location = "__appresourcegrouplocation__"
}

resource "azurerm_app_service_plan" "dev" {
  name                = "__appserviceplan__"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "dev" {
  name                = "__appservicename__"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  app_service_plan_id = azurerm_app_service_plan.dev.id
  https_only          = true

  site_config {
    use_32_bit_worker_process = true
  }

}
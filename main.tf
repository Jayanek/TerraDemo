provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name = "azuretf"
  location = "South India"
}

resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapiapp"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type     = "Public"
  dns_name_label      = "intermediacodeswks"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "algomartstoresl/algomart:latest"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }


}
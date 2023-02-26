provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name = "azuretf"
  location = "South India"
}

terraform {
    backend "azurerm" {
        resource_group_name  = "terra-storage"
        storage_account_name = "terrablobstorage"
        container_name       = "terracon"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
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
      image           = "algomartstoresl/algomart:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }


}
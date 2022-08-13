
output "prod_url" {
  value = "https://${azurerm_linux_web_app.web-app.name}.azurewebsites.net"
}

output "slot_1_url" {
  value = "https://${azurerm_linux_web_app.web-app.name}-${azurerm_linux_web_app_slot.slot-1.name}.azurewebsites.net"
}

output "slot-0" {
  value = azurerm_linux_web_app.web-app
  #sensitive = true
}

output "slot-1" {
  value = azurerm_linux_web_app_slot.slot-1
}
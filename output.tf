
//output "prod_url" {
//  value = "https://${azurerm_linux_web_app.web_app[count.index].name}.azurewebsites.net"
//}
//
//output "slot_1_url" {
//  value = "https://${azurerm_linux_web_app.web_app[count.index].name}-${azurerm_linux_web_app_slot[count.index].slot_1.name}.azurewebsites.net"
//}
//
//output "slot_0" {
//  value = azurerm_linux_web_app.web_app
//  #sensitive = true
//}
//
//output "slot_1" {
//  value = azurerm_linux_web_app_slot.slot_1
//}
/*
Create a web app service plan.
An App Service plan defines a set of compute resources for a web app to run.
These compute resources are analogous to the server farm in conventional web hosting. 
One or more apps can be configured to run on the same computing resources (or in the same App Service plan).
*/
resource "azurerm_service_plan" "sp" {
  name                = "webapp-sp-linux"
  location            = var.location
  resource_group_name = var.resource-group-name
  os_type             = "Linux"
  sku_name            = var.plan-sku-name
}

/*
Create a linux web app service.
Azure App Service is an HTTP-based (Paas) service for hosting web applications, REST APIs, and mobile back ends. 
The folowing languages are supported, .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python. 
Applications run and scale on both Windows and Linux-based environments.
*/
resource "azurerm_linux_web_app" "web-app" {
  name                = var.web-app-name
  location            = var.location
  resource_group_name = var.resource-group-name
  service_plan_id     = azurerm_service_plan.sp.id
  https_only          = true

  site_config {

    always_on           = false
    ftps_state = "Disabled"
    health_check_eviction_time_in_min = 10
    health_check_path = "/"
    http2_enabled = false
    ip_restriction = tolist([])
    load_balancing_mode = "LeastRequests"
    local_mysql_enabled = false
    managed_pipeline_mode = "Integrated"
    minimum_tls_version = "1.2"
    remote_debugging_enabled = false
    remote_debugging_version = "VS2019"
    scm_ip_restriction = tolist([])
    scm_minimum_tls_version = "1.2"
    scm_use_main_ip_restriction = false
    use_32_bit_worker = true
    vnet_route_all_enabled = false
    websockets_enabled = false
    worker_count = 1

    application_stack {
      node_version = "16-lts"
    }

  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true
    application_logs {
      file_system_level = "Verbose"
    }
    http_logs {

      file_system {
        retention_in_mb   = 25
        retention_in_days = 1
      }

    }
  }
}

/*
Create a app service source control for the default production slot.
The linux web app service above creates the production slot by default.
This pulls the NodeJS HW app from a branch called production.
*/
resource "azurerm_app_service_source_control" "production-source" {
  app_id                 = azurerm_linux_web_app.web-app.id
  repo_url               = var.repo-url-slot-0
  branch                 = var.branch-slot-0
  use_manual_integration = true
  use_mercurial          = false
}

/*
Create a linux web app slot for a staging instance
Slots are different environments exposed via a publicly available endpoint. 
One app instance is always mapped to the production slot, and you can swap instances assigned to a slot on demand.
*/

resource "azurerm_linux_web_app_slot" "slot-1" {
  name           = var.slot-1-name
  app_service_id = azurerm_linux_web_app.web-app.id
  https_only     = true

  site_config {
    minimum_tls_version = "1.2"
    always_on           = false
    application_stack {
      node_version = "16-lts"
    }

    health_check_eviction_time_in_min = 10
    health_check_path                 = "/"
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true
    application_logs {
      file_system_level = "Verbose"
    }
    http_logs {
      file_system {
        retention_in_mb   = 25
        retention_in_days = 1
      }
    }
  }
}

/*
Create a app service source control for the staging slot.
This pulls the NodeJS HW app from a branch called main.
*/
resource "azurerm_app_service_source_control_slot" "staging-source" {
  slot_id                = azurerm_linux_web_app_slot.slot-1.id
  repo_url               = var.repo-url-slot-1
  branch                 = var.branch-slot-1
  use_manual_integration = true
  use_mercurial          = false
}

/*
  Need to figure out how to set the OAuth token between the app service and GitHub
*/
# resource "azurerm_source_control_token" "sc-token" {
#   type  = "GitHub"
#   token = "FRANKNAW2"
#   # token = "AZUREAPPSERVICE_PUBLISHPROFILE_B2DF17BDEDB84EBDB0A136CDEE0403B7"
# }

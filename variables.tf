variable "location" {
  description = "Azure location to deploy resources"
  type        = string
}

variable "plan_os_type" {
  description = "Service plan os type"
  type        = string
}

variable "plan_sku_name" {
  description = "Service plan sku name"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "web_app_name" {
  description = "Base web app name"
  type        = string
}

variable "slot_1_name" {
  description = "Slot One name"
  type        = string
}

variable "repo_url_slot_0" {
  description = "Slot Zero Repo"
  type        = string
}

variable "branch_slot_0" {
  description = "Slot Zero Branch"
  type        = string
}

variable "repo_url_slot_1" {
  description = "Slot One Repo"
  type        = string
}

variable "branch_slot_1" {
  description = "Slot One Branch"
  type        = string
}

variable "product_name" {
  description = "Product name"
  type        = string
}

variable "tags" {
  description = "Map of tags"
  type        =  map(string)
}

variable "service_plan" {
  description = "Service plan"
}

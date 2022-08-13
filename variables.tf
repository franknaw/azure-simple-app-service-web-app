variable "location" {
  description = "Azure location to deploy resources"
  type        = string
}

variable "plan-sku-name" {
  description = "Service plan sku name"
  type        = string
}

variable "resource-group-name" {
  description = "Azure resource group name"
  type        = string
}

variable "web-app-name" {
  description = "Base web app name"
  type        = string
}

variable "slot-1-name" {
  description = "Slot One name"
  type        = string
}

variable "repo-url-slot-0" {
  description = "Slot Zero Repo"
  type        = string
}

variable "branch-slot-0" {
  description = "Slot Zero Branch"
  type        = string
}


variable "repo-url-slot-1" {
  description = "Slot One Repo"
  type        = string
}

variable "branch-slot-1" {
  description = "Slot One Branch"
  type        = string
}

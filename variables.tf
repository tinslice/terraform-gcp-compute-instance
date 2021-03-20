variable "project" {
  default = null
}

variable "region" {
  default = null
}

variable "zone" {
  default = null
}

variable "resource_prefix" {
  default = null
}

variable "name" {}
variable "machine_type" {}

variable "boot_disk_image" {}

variable "boot_disk_size" {
  default = 10
}

variable "enable_secure_boot" {
  default = true
}

variable "allow_stopping_for_update" {
  default = true
}

variable "enable_integrity_monitoring" {
  default = true
}

variable "enable_vtpm" {
  default = true
}

variable "metadata" {
  type = map
  default = {}
}

variable "startup_script" {
  type = string
  default = null
}

variable "tags" {
  type = list
  default = []
}

variable "labels" {
  type        = map(map(string))
  description = "Map of maps containing labels by object name"

  # Default is being set in variables_defaults.tf
  default = {
    all   = {}
    node  = {}
  }
}

variable "disks" {
  type        = list(map(string))
  description = "List of maps containing disk info"

  # Default is being set in variables_defaults.tf
  default = []
}

variable "network_interface_defaults" {
  type = object({
    network             = string
    subnetwork          = string
    subnetwork_project  = string
    network_ip          = string
    access_config       = map(any)
  })

  default = {
    network             = null
    subnetwork          = null
    subnetwork_project  = null
    network_ip          = null
    access_config       = null
  }
}

variable "network_interfaces" {}

variable "service_account" {
  default = null
}

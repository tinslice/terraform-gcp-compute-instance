locals {
  resource_prefix = var.resource_prefix == null ? "" : "${var.resource_prefix}-"
  instance_name = "${local.resource_prefix}${var.name}"
  labels = merge(
    { all = {} },
    zipmap(
      [for disk in var.disks : disk["name"]],
      [for disk in var.disks : {}]
    ),
    var.labels
  )

  disks = {
    for i, disk in var.disks :
      lookup(disk, "name", null) => disk
  }

  network_interfaces = [
    for i, interface in var.network_interfaces :
      merge(var.network_interface_defaults, interface)
  ]
}
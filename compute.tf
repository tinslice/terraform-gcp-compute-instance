resource "google_compute_instance" "this" {
  name                      = local.instance_name
  machine_type              = var.machine_type
  zone                      = var.zone

  allow_stopping_for_update = var.allow_stopping_for_update

  labels = local.labels["all"]

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  shielded_instance_config {
    enable_integrity_monitoring = var.enable_integrity_monitoring
    enable_secure_boot          = var.enable_secure_boot
    enable_vtpm                 = var.enable_vtpm
  }

  dynamic "network_interface" {
    for_each = local.network_interfaces

    content {
      network             = lookup(network_interface.value, "network", null)
      subnetwork          = lookup(network_interface.value, "subnetwork", null)
      subnetwork_project  = lookup(network_interface.value, "subnetwork_project", null)
      network_ip          = lookup(network_interface.value, "network_ip", null)

      dynamic "access_config" {
        for_each = lookup(network_interface.value, "access_config", null) == null ? [] : [ network_interface.value["access_config"] ]
        content {
          nat_ip                  = lookup(access_config.value, "nat_ip", null)
          public_ptr_domain_name  = lookup(access_config.value, "public_ptr_domain_name", null)
          network_tier            = lookup(access_config.value, "network_tier", null)
        }
      }
    }
  }

  metadata = merge(
    var.metadata
  )

  dynamic "attached_disk" {
    for_each = local.disks

    content {
      source = "${local.instance_name}-${attached_disk.key}"
      device_name = attached_disk.key
    }
  }

  metadata_startup_script = var.startup_script

  dynamic "service_account" {
    for_each = var.service_account == null ? [] : [ var.service_account ]
    content {
      email   = lookup(service_account.value, "email", null)
      scopes  = lookup(service_account.value, "scopes", null)
    }
  }

  depends_on = [
    google_compute_disk.disk,
  ]
}
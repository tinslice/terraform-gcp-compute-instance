resource "google_compute_disk" "disk" {
  for_each = local.disks

  name  = "${local.instance_name}-${each.key}"
  size  = lookup(each.value, "size", 10)
  type  = lookup(each.value, "type", "pd-standard")
  zone  = var.zone

  labels = merge(
    local.labels["all"],
    local.labels[each.key]
  )
}
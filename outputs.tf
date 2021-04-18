output "instance" {
  value = google_compute_instance.this
  sensitive = true
}

output "name" {
  value = google_compute_instance.this.name
}

output "zone" {
  value = google_compute_instance.this.zone
}

output "id" {
  value = google_compute_instance.this.id
}

output "instance_id" {
  value = google_compute_instance.this.instance_id
}

output "hostname" {
  value = google_compute_instance.this.hostname
}

output "current_status" {
  value = google_compute_instance.this.current_status
}

output "can_ip_forward" {
  value = google_compute_instance.this.can_ip_forward
}

output "labels" {
  value = google_compute_instance.this.labels
}

output "machine_type" {
  value = google_compute_instance.this.machine_type
}

output "project" {
  value = google_compute_instance.this.project
}

output "allow_stopping_for_update" {
  value = google_compute_instance.this.allow_stopping_for_update
}

output "attached_disk" {
  value     = google_compute_instance.this.attached_disk
  sensitive = true
}

output "network_interface" {
  value = google_compute_instance.this.network_interface
}

output "tags" {
  value = google_compute_instance.this.tags
}


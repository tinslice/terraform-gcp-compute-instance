# compute-instance

Create GCP compute instance.

Please check [google_compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#network_interface) for available options.

## Usage example

```terraform

resource "google_service_account" "test_server_service_account" {
  account_id   = "service-account-id" # It is unique within a project, must be 6-30 characters long, and match the regular expression [a-z]([-a-z0-9]*[a-z0-9]) to comply with RFC1035.
  display_name = "Service Account"
}

module "test_server" {
  source          = ""

  name            = "test-server"
  resource_prefix = "dev"         # if defined, it will prefix the name of created resources with the specified value
  machine_type    = "f1-micro"
  boot_disk_image = "debian-cloud/debian-9"
  boot_disk_size  = 10
  region          = "us-west1"
  zone            = "us-west1-a"

  tags      = []
  metadata  = {
    ssh-keys = ""
  }

  labels = {
    all   = {}
    logs  = {}
  }

  disks = [
    {
      name = "logs"
      size = 5
      type = "pd-standard" # default value 'pd-standard'
    }
  ]

  network_interfaces = [
    {
      subnetwork    = "subnet-id"   # eg. google_compute_subnetwork.mysubnet.self_link
      network_ip    = "private-ip"  # eg. "10.150.0.2"
    }
  ]

  service_account = {
    email  = google_service_account.test_server_service_account.email
    scopes = [ "cloud-platform" ]
  }

  startup_script = "echo 'test' > /test.txt"
}
```
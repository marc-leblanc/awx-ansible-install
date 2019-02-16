provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.gcp_project_id}"
  region      = "${var.gcp_region}"
  zone        = "${var.gcp_region}-${var.gcp_zone}"
}

// Create a new instance
resource "google_compute_instance" "Arc1" {
  count = 1
  #name         = "am1-test"
  machine_type = "n1-standard-1"
  zone         = "${var.gcp_region}-${var.gcp_zone}"
  name = "${var.gcp_instance_name}"


  boot_disk {
    initialize_params {
      image = ${var.gcp_instance_os}
    }
  }

 network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
   }
}
  ##metadata {
    #foo = "bar"
  #}

#  metadata_startup_script = "echo hi > /test.txt"

  #metadata_startup_script = "echo ${data.google_compute_address.my_address.address} > /root/yourIP"


  #service_account {
  #  scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  #}


}
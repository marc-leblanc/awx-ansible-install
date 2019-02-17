provider "google" {
  credentials = "${file("${var.gcp_json}")}"
  project     = "${var.gcp_project_id}"
  region      = "${var.gcp_region}"
  zone        = "${var.gcp_region}-${var.gcp_zone}"
}

// Create a new instance
resource "google_compute_instance" "Arc1" {
  count = 1
  machine_type = "n1-standard-1"
  zone         = "${var.gcp_region}-${var.gcp_zone}"
  name = "${var.gcp_instance_name}"


  boot_disk {
    initialize_params {
      image = "${var.gcp_instance_os}"
    }
  }

 network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
   }
}

  tags=["http","https"]
  metadata {
     ssh-keys = "mleblanc:${file("~/.ssh/id_gcp_rsa.pub")}"
  }
  provisioner "remote-exec" {
    connection { 
      type    = "ssh"
      user    = "mleblanc"
      timeout = "500s"
      private_key = "${file("~/.ssh/id_gcp_rsa")}"
    }
    inline = [

      "sudo yum -y install git ansible",
      "sudo mkdir /root/prep-awx",
      "sudo cd /root/prep-awx",
      "sudo git init",
      "sudo git remote add origin https://github.com/marc-leblanc/awx-ansible-install.git",
      "sudo git pull https://github.com/marc-leblanc/awx-ansible-install/",
      "sudo cd prep-awx",
      "sudo ansible-playbook prep-awx.yml"
    ]

  }

}

resource "google_compute_firewall" "default" {
 name    = "web-firewall"
 network = "default"

 allow {
   protocol = "icmp"
 }

 allow {
   protocol = "tcp"
   ports    = ["80","443","8443"]
 }

 source_ranges = ["0.0.0.0/0"]
 target_tags = ["http","https"]
}

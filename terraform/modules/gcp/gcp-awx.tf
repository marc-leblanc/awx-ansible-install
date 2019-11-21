provider "google" {
  credentials = file("${var.gcp_json}")
  project     = var.gcp_project_id
  region      = var.gcp_region
  zone        = "${var.gcp_region}-${var.gcp_zone}"
  version     = "~> 2.17.0"
}

// Create a new instance
resource "google_compute_instance" "awx01" {
  machine_type = "n1-standard-1"
  zone         = "${var.gcp_region}-${var.gcp_zone}"
  name         = var.gcp_instance_name

  boot_disk {
    initialize_params {
      image = var.gcp_instance_os
    }
  }

 network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
   }
}
  // Add http/https network tags for use in firewall rule creation
  tags=["http","https"]
  
  // Add the public key defined in main.tf as a meta tag 
  metadata = {
     ssh-keys = "${var.ssh_user}:${file("${var.ssh_key_path}${var.ssh_key_pub}")}"
  }

  provisioner "file" {
    connection { 
      type    = "ssh"
      user    = var.ssh_user
      timeout = "600s"
      private_key = file("${var.ssh_key_path}${var.ssh_key_priv}")
      host    = google_compute_instance.awx01.network_interface[0].access_config[0].nat_ip
    }
    source = "../ansible/${var.ansible_playbook}"
    destination = "/tmp/${var.ansible_playbook}"
  }

  // Remote Exec provisioner is used to bootstrap the instance with GIT/Ansible and run 
  // the playbook to install AWX. It connects via SSH using the SSH Keys provisioned previously 
  // as defined in main.tf 

  provisioner "remote-exec" {
    connection { 
      type    = "ssh"
      user    = var.ssh_user
      timeout = "500s"
      private_key = file("${var.ssh_key_path}${var.ssh_key_priv}")
      host    = google_compute_instance.awx01.network_interface[0].access_config[0].nat_ip
    }
    inline = [
      "sudo yum -y install ansible",
      "sudo ansible-playbook -i localhost /tmp/${var.ansible_playbook}"
    ]
  }
}
// Create a firewall Rule to allow instances tagged with http/https 
resource "google_compute_firewall" "default" {
 name    = "web-firewall"
 network = "default"

 allow {
   protocol = "icmp"
 }

 allow {
   protocol = "tcp"
   ports    = ["80","443","22"]
 }

 source_ranges = ["0.0.0.0/0"]
 target_tags = ["http","https","ssh"]
}

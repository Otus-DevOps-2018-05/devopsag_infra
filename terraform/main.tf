provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  metadata {
    ssh-keys = "appuser2:${file("~/.ssh/appuser.pub")}appuser:${file("~/.ssh/appuser.pub")}appuser1:${file("~/.ssh/appuser.pub")}"
  }
  count        = "${var.count}"
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  connection {
    type = "ssh"

    user = "appuser"

    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source = "files/puma.service"

    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

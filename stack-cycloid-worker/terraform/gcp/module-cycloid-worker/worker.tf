resource "google_compute_firewall" "cycloid-worker" {
  name    = "${var.customer}-${var.project}-${var.env}-cycloid-worker"
  network = google_compute_network.cycloid-worker.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "cycloid-worker" {
  name           = "${var.customer}-${var.project}-${var.env}-cycloid-worker"
  machine_type   = var.vm_machine_type
  can_ip_forward = false
  zone           = data.google_compute_zones.available.names[length(data.google_compute_zones.available.names)-1]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size  = var.vm_disk_size
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cycloid-worker.name

    access_config {
      // Ephemeral public IP
      network_tier = "STANDARD"
    }
  }

  metadata = {
    sshKeys = "${var.vm_os_user}:${var.keypair_public}"

    user-data = base64encode(templatefile(
      "${path.module}/userdata.sh.tpl",
      {
        organisation = var.customer
        project = var.project
        env = var.env
        TEAM_ID = var.team_id
        WORKER_KEY = base64encode(var.worker_key)
      }
    ))
  }

  labels = merge(local.merged_tags, {
    role = "cycloid-worker"
  })
}
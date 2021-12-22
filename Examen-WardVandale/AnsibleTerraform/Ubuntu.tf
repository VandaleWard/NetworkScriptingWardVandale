provider "vsphere" {
  user           = var.username
  password       = var.password
  vsphere_server = "192.168.50.10"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "null_resource" "create_vault" {
  provisioner "local-exec" {
    command = "echo \"${var.vault_pass}\" > .vault_pass"
  }
}

data "vsphere_datacenter" "dc" {
  name = "StudentDatacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "vandale-ward"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "StudentCluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "ubuntu-template" {
  name          = "ubuntu-template-examen"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "folder" {
  path          = var.folder_path
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "ward-ubu" {
  name             = "ward-ubu"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = var.folder_path

  num_cpus = "4"
  memory   = 2
  guest_id = data.vsphere_virtual_machine.ubuntu-template.guest_id

  scsi_type = data.vsphere_virtual_machine.ubuntu-template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.ubuntu-template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.ubuntu-template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.ubuntu-template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.ubuntu-template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu-template.id

    customize {
      linux_options {
        host_name = "ward-ubu"
        domain    = "lab.local"
      }

      network_interface {
        ipv4_address = "192.168.40.50"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.40.1"
      dns_server_list = ["192.168.40.1"]
    }
  }
}
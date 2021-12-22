provider "vsphere" {
  user           = var.user
  password       = var.password
  vsphere_server = "192.168.50.10"

  # If you have a self-signed cert
  allow_unverified_ssl = true

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

data "vsphere_virtual_machine" "windows" {
  name          = "win-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_folder" "folder" {
  path          = var.folder_path
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

#create windows vm

resource "vsphere_virtual_machine" "windows_vm" {
  name             = "${var.student}-win"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = var.folder_path

  num_cpus = data.vsphere_virtual_machine.windows.num_cpus
  memory   = data.vsphere_virtual_machine.windows.memory
  guest_id = data.vsphere_virtual_machine.windows.guest_id

  scsi_type = data.vsphere_virtual_machine.windows.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.windows.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.windows.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.windows.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.windows.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.windows.id

    customize {
      windows_options {
        computer_name = "${var.student}-win"
        workgroup = "lab.local"
        admin_password = var.vm_pwd
      }

      network_interface {
        ipv4_address = "192.168.50.60"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.50.1"
      dns_server_list = ["172.20.0.2", "172.20.0.3"]
    }
  }

}
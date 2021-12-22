data "vsphere_virtual_machine" "ubuntu" {
  name          = "ubuntu-template-examen"
  datacenter_id = data.vsphere_datacenter.dc.id
}


#create ubuntu vm

resource "vsphere_virtual_machine" "ubunutu_vm" {
  name             = "${var.student}-ubu"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = var.folder_path

  num_cpus = 4
  memory   = 2048
  guest_id = data.vsphere_virtual_machine.ubuntu.guest_id

  scsi_type = data.vsphere_virtual_machine.ubuntu.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.ubuntu.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.ubuntu.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.ubuntu.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.ubuntu.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id

    customize {
      linux_options {
        host_name = "${var.student}-ubu"
        domain    = "lab.local"
      }

      network_interface {
        ipv4_address = "192.168.50.61"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.50.1"
      dns_server_list = ["192.168.40.1"]
    }
  }

}
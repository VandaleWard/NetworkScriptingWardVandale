data "vsphere_virtual_machine" "windows-template" {
  name = "win-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "windows" {
  name             = "ward-win"
  folder = var.folder_path
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id = data.vsphere_datastore.datastore.id

  num_cpus = data.vsphere_virtual_machine.windows-template.num_cpus
  memory = data.vsphere_virtual_machine.windows-template.memory
  guest_id = data.vsphere_virtual_machine.windows-template.guest_id

  scsi_type = data.vsphere_virtual_machine.windows-template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.windows-template.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size             = data.vsphere_virtual_machine.windows-template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.windows-template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.windows-template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.windows-template.id

    customize {
      windows_options {
        computer_name = "ward"
      }

      network_interface {
        ipv4_address = "192.168.50.51"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "192.168.50.1"
      dns_server_list = ["172.20.0.2", "172.20.0.3"]
    }
  }
}
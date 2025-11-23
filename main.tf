terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_api_url = "https://192.168.0.224:8006/api2/json"
  pm_tls_insecure = true
  pm_user = "root@pam"
  pm_password = var.pm_password
  
}

resource "proxmox_vm_qemu" "vm-redos" {
  name = "test-redos"
  target_node = "pve"
  clone = "redos-minimal-server"
  onboot = true
  agent = 1
  os_type = "cloud-init"
  cpu {
        cores = 2
        sockets = 2
        type = "host"
    }
  memory = 4096
  network {
    model = "virtio"
    id = 0
    bridge = "vmbr0"
    firewall = false
  }
  disks {
        scsi {
            scsi0 {
                disk {
                    size            = 80
                    cache           = "writeback"
                    storage         = "SATA_c7_7_R1"

                }
            }
        }
    }
  
  boot = "order=scsi0"
    
}

resource "proxmox_vm_qemu" "vm-ubuntu" {
  name = "test-ubuntu"
  target_node = "pve"
  clone = "ubuntu22"
  onboot = true
  agent = 1
  os_type = "cloud-init"
  cpu {
        cores = 2
        sockets = 2
        type = "host"
    }
  memory = 4096
  network {
    model = "virtio"
    id = 0
    bridge = "vmbr0"
    firewall = false
  }
  disks {
        scsi {
            scsi0 {
                disk {
                    size            = 80
                    cache           = "writeback"
                    storage         = "SATA_c8_8_R1"

                }
            }
        }
    }
  
  boot = "order=scsi0"
 
}
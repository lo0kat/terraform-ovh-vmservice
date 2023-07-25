provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3" # Authentication URL
  domain_name = "default"                       # Domain name - Always at 'default' for OVHcloud
  alias       = "ovh"                           # An alias
}
provider "ovh" {
  alias    = "ovh"
  endpoint = "ovh-eu"
}



# Creating an SSH key pair
resource "ovh_me_ssh_key" "account_keypair" {
  key_name = "ovh_vm_keypair"
  key      = var.public_key
}


data "openstack_images_image_v2" "debian" {
  name        = "Debian 11"   # Image name
  most_recent = true          # Limits search to the most recent
  provider    = openstack.ovh # Provider name
  region      =  var.region
}


# Creating the instance
resource "openstack_compute_instance_v2" "terraform_instance" {
  name        = var.vm_name   # Instance name
  provider    = openstack.ovh # Provider name
  image_id    = data.openstack_images_image_v2.debian.id
  flavor_name = var.vm_flavor # Instance type name
  region      = var.region
  # Name of openstack_compute_keypair_v2 resource named keypair_test
  key_pair        = ovh_me_ssh_key.account_keypair.key_name
  security_groups = [openstack_networking_secgroup_v2.vm_service_sg1.name]
  network {
    name = "Ext-Net" # Adds the network component to reach your instance
  }

  # network {
  #   name = ovh_cloud_project_network_private_subnet.name
  # }

  block_device {
    uuid                  = data.openstack_images_image_v2.debian.id # Instance image ID
    source_type           = "image"                                  # Source type
    destination_type      = "local"                                  # Destination
    volume_size           = 20                                       # Size
    boot_index            = 0                                        # Boot order
    delete_on_termination = true                                     # The device will be deleted when the instance is deleted
  }
}
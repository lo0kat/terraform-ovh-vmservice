terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "0.32"
    }

    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.52.1"
    }
  }
}
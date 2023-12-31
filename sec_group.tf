resource "openstack_networking_secgroup_v2" "vm_service_sg1" {
  provider    = openstack.ovh # Specify provider name
  name        = "vm_service_sg1"
  description = "HTTPS and SSH security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  provider          = openstack.ovh # Specify provider name
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vm_service_sg1.id
}


resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ingress_https" {
  provider          = openstack.ovh # Specify provider name
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vm_service_sg1.id
}


resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_egress_https" {
  provider          = openstack.ovh # Specify provider name
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vm_service_sg1.id
}
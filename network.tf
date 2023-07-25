# data "ovh_order_cart" "mycart" {
#   ovh_subsidiary = "fr"
#   description    = "my vrack order cart"
# }

# data "ovh_order_cart_product_plan" "vrack" {
#   cart_id        = data.ovh_order_cart.mycart.id
#   price_capacity = "renew"
#   product        = "vrack"
#   plan_code      = "vrack"
# }

# resource "ovh_vrack" "vrack" {
#   ovh_subsidiary = data.ovh_order_cart.mycart.ovh_subsidiary
#   name           = "my vrack"
#   description    = "my vrack"

#   plan {
#     duration     = data.ovh_order_cart_product_plan.vrack.selected_price.0.duration
#     plan_code    = data.ovh_order_cart_product_plan.vrack.plan_code
#     pricing_mode = data.ovh_order_cart_product_plan.vrack.selected_price.0.pricing_mode
#   }
# }

# # Associating cloud project to vRack
#  resource "ovh_vrack_cloudproject" "vcp" {
#   service_name = var.service_name
#   project_id   = var.project_id
# } 


#  # Creating a private network
#  resource "ovh_cloud_project_network_private" "network" {
#     service_name = var.service_name
#     name         = "private_network" # Network name
#     regions      = [var.region]
#     provider     = ovh.ovh # Provider name
#     vlan_id      = 100 # VLAN ID for vRack
#     depends_on   = [ovh_vrack_cloudproject.vcp] # Depends on the vRack's association with the cloud project
#  }

#  # Creating a subnet using the previously created private network
#  resource "ovh_cloud_project_network_private_subnet" "subnet" {
#     service_name = var.service_name
#     # ID of the ovh_cloud_network_private resource named network
#     network_id   = ovh_cloud_project_network_private.network.id
#     start        = "192.168.168.100" # First IP of the subnet
#     end          = "192.168.168.200" # Last IP of the subnet
#     network      = "192.168.168.0/24" # Subnet IP address location
#     dhcp         = true # Enables DHCP
#     region       = var.region
#     provider     = ovh.ovh # Provider name
#     no_gateway   = false # default gateway
#  }


# Resource Group Module is Used to Create Resource Groups
module "hub-resourcegroup" {
source = "./modules/resourcegroups"
# Resource Group Variables
# az_rg_name      = "Hub-WestEurope-RG"
az_rg_name      = var.hub_az_rg_name
az_rg_location  = "westeurope"
}

# Resource Group Module is Used to Create Resource Groups
module "spoke-prod-resourcegroup" {
source = "./modules/resourcegroups"
# Resource Group Variables
# az_rg_name     = "Spoke-Prod-WestEurope-RG"
az_rg_name     = var.spoke_prod_az_rg_name
az_rg_location = "westeurope"
}

# Resource Group Module is Used to Create Resource Groups
module "spoke-lab-resourcegroup" {
source = "./modules/resourcegroups"
# Resource Group Variables
# az_rg_name     = "Spoke-TS-WestEurope-RG"
az_rg_name     = var.spoke_lab_az_rg_name
az_rg_location = "westeurope"
}

# vnet Module is used to create Virtual Networks and Subnets
module "hub-vnet" {
source = "./modules/vnet"

virtual_network_name              = "Hub-Vnet"
resource_group_name               = module.hub-resourcegroup.rg_name
location                          = module.hub-resourcegroup.rg_location
virtual_network_address_space     = ["10.10.0.0/16"]
subnet_names = {
    "GatewaySubnet" = {
        subnet_name = "GatewaySubnet"
        address_prefixes = ["10.10.1.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
    "AzureFirewallSubnet" = {
        subnet_name = "AzureFirewallSubnet"
        address_prefixes = ["10.10.2.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
    }
}

# vnet Module is used to create Virtual Networks and Subnets
module "spoke-prod-vnet" {
source = "./modules/vnet"

virtual_network_name              = "Spoke-Prod-WestEurope-Vnet"
resource_group_name               = module.spoke-prod-resourcegroup.rg_name
location                          = module.spoke-prod-resourcegroup.rg_location
virtual_network_address_space     = ["10.11.0.0/16"]
subnet_names = {
    "spoke-prod-snet01" = {
        subnet_name = "DCSubnet"
        address_prefixes = ["10.11.1.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
    "spoke-prod-snet02" = {
        subnet_name = "SQLSubnet"
        address_prefixes = ["10.11.2.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
     "spoke-prod-snet03" = {
        subnet_name = "ServersSubnet"
        address_prefixes = ["10.11.3.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
    "spoke-prod-snet04" = {
        subnet_name = "FSSubnet"
        address_prefixes = ["10.11.4.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    }
    }
}

# vnet Module is used to create Virtual Networks and Subnets
module "spoke-lab-vnet" {
source = "./modules/vnet"

virtual_network_name              = "Spoke-TS-WestEurope-Vnet"
resource_group_name               = module.spoke-lab-resourcegroup.rg_name
location                          = module.spoke-lab-resourcegroup.rg_location
virtual_network_address_space     = ["10.62.0.0/16"]
subnet_names = {
    "spoke-lab-snet01" = {
        subnet_name = "TSProdSubnet"
        address_prefixes = ["10.62.1.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
    "spoke-lab-snet02" = {
        subnet_name = "TSLabSubnet"
        address_prefixes = ["10.62.2.0/24"]
        route_table_name = ""
        snet_delegation  = ""
    },
    }
}

# vnet-peering Module is used to create peering between Virtual Networks
module "hub-to-spoke-prod" {
source = "./modules/vnet-peering"
depends_on = [module.hub-vnet , module.spoke-prod-vnet , module.vpn_gateway ]
#depends_on = [module.hub-vnet , module.spoke1-vnet , module.application_gateway, module.vpn_gateway , module.azure_firewall_01]

virtual_network_peering_name = "Hub-to-Spoke-Prod"
resource_group_name          = module.hub-resourcegroup.rg_name
virtual_network_name         = module.hub-vnet.vnet_name
remote_virtual_network_id    = module.spoke-prod-vnet.vnet_id
allow_virtual_network_access = "true"
allow_forwarded_traffic      = "true"
allow_gateway_transit        = "true"
use_remote_gateways          = "false"

}
# vnet-peering Module is used to create peering between Virtual Networks
module "hub-to-spoke-lab" {
source = "./modules/vnet-peering"
depends_on = [module.hub-vnet , module.spoke-lab-vnet /**, module.azure_firewall_01**/]
#depends_on = [module.hub-vnet , module.spoke1-vnet , module.application_gateway, module.vpn_gateway , module.azure_firewall_01]

virtual_network_peering_name = "Hub-to-Spoke-TS"
resource_group_name          = module.hub-resourcegroup.rg_name
virtual_network_name         = module.hub-vnet.vnet_name
remote_virtual_network_id    = module.spoke-lab-vnet.vnet_id
allow_virtual_network_access = "true"
allow_forwarded_traffic      = "true"
allow_gateway_transit        = "true"
use_remote_gateways          = "false"

}
# vnet-peering Module is used to create peering between Virtual Networks
module "spoke-prod-to-hub" {
source = "./modules/vnet-peering"

virtual_network_peering_name = "Spoke-Prod-to-Hub"
resource_group_name          = module.spoke-prod-resourcegroup.rg_name
virtual_network_name         = module.spoke-prod-vnet.vnet_name
remote_virtual_network_id    = module.hub-vnet.vnet_id
allow_virtual_network_access = "true"
allow_forwarded_traffic      = "true"
allow_gateway_transit        = "false"
use_remote_gateways          = "false"
depends_on = [module.hub-vnet , module.spoke-prod-vnet]
}
# vnet-peering Module is used to create peering between Virtual Networks
module "spoke-lab-to-hub" {
source = "./modules/vnet-peering"

virtual_network_peering_name = "Spoke-TS-to-Hub"
resource_group_name          = module.spoke-lab-resourcegroup.rg_name
virtual_network_name         = module.spoke-lab-vnet.vnet_name
remote_virtual_network_id    = module.hub-vnet.vnet_id
allow_virtual_network_access = "true"
allow_forwarded_traffic      = "true"
allow_gateway_transit        = "false"
use_remote_gateways          = "false"
depends_on = [module.hub-vnet , module.spoke-lab-vnet]
}

# routetables Module is used to create route tables and associate them with Subnets created by Virtual Networks
module "route_tables01" {
source = "./modules/routetables"
depends_on = [module.hub-vnet , module.spoke-prod-vnet]

route_table_name              = "RouteTable01-WestEurope"
location                      = module.hub-resourcegroup.rg_location
resource_group_name           = module.hub-resourcegroup.rg_name
disable_bgp_route_propagation = false

route_name                    = "ToVirtualNetworkGateway"
address_prefix                = "0.0.0.0/0"
next_hop_type                 = "VirtualNetworkGateway"


subnet_id_01                  = module.spoke-prod-vnet.vnet_subnet_id[0]
subnet_id_02                  = module.spoke-prod-vnet.vnet_subnet_id[1]
subnet_id_03                  = module.spoke-prod-vnet.vnet_subnet_id[2]
subnet_id_04                  = module.spoke-prod-vnet.vnet_subnet_id[3]


}

# routetables Module is used to create route tables and associate them with Subnets created by Virtual Networks
module "route_tables02" {
source = "./modules/routetables"
depends_on = [module.hub-vnet , module.spoke-lab-vnet]

route_table_name              = "RouteTable02-WestEurope"
location                      = module.hub-resourcegroup.rg_location
resource_group_name           = module.hub-resourcegroup.rg_name
disable_bgp_route_propagation = false

route_name                    = "ToVirtualNetworkGateway"
address_prefix                = "0.0.0.0/0"
next_hop_type                 = "VirtualNetworkGateway"

subnet_id_01                  = module.spoke-lab-vnet.vnet_subnet_id[0]
subnet_id_02                  = module.spoke-lab-vnet.vnet_subnet_id[1]
subnet_id_03                  = module.spoke-lab-vnet.vnet_subnet_id[0]
subnet_id_04                  = module.spoke-lab-vnet.vnet_subnet_id[1]
}


# publicip Module is used to create Public IP Address
module "public_ip_01" {
source = "./modules/publicip"

# Used for VPN Gateway 
public_ip_name      = "AZ-WestEurope-VGW-PIP01"
resource_group_name = module.hub-resourcegroup.rg_name
location            = module.hub-resourcegroup.rg_location
allocation_method   = "Static"
sku                 = "Standard"
}


/** publicip Module is used to create Public IP Address
module "public_ip_02" {
source = "./modules/publicip"

# Used for Azure Firewall 
public_ip_name      = "AZ-WestEurope-AFW-PIP02"
resource_group_name = module.hub-resourcegroup.rg_name
location            = module.hub-resourcegroup.rg_location
allocation_method   = "Static"
sku                 = "Standard"
}


# azurefirewall Module is used to create Azure Firewall 
# Firewall Policy
# Associate Firewall Policy with Azure Firewall
# Network and Application Firewall Rules 
module "azure_firewall_01" {
source = "./modules/azurefirewall"
depends_on = [module.hub-vnet]

  azure_firewall_name = "AZFW-westeurope"
  location            = module.hub-resourcegroup.rg_location
  resource_group_name = module.hub-resourcegroup.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ipconfig_name        = "PIP"
  subnet_id            = module.hub-vnet.vnet_subnet_id[0]
  public_ip_address_id = module.public_ip_02.public_ip_address_id

azure_firewall_policy_coll_group_name  = "AFW-coll-pol01" 
azure_firewall_policy_name             = "AFW-pol01"  
priority                               = 100

network_rule_coll_name_01     = "Blocked_Network_Rules"
  network_rule_coll_priority_01 = "700"
  network_rule_coll_action_01   = "Deny"
  network_rules_01 = [   
        {    
            name                  = "Blocked_rule_1"
            source_addresses      = ["*"]
            destination_addresses = ["*"]
            destination_ports     = ["*"]
            protocols             = ["Any"]
        },
    ]  
network_rule_coll_name_02     = "Allowed_Network_Rules"
  network_rule_coll_priority_02 = "600"
  network_rule_coll_action_02   = "Allow"
  network_rules_02 = [   
        {    
            name                  = "Allowed_Network_rule_1"
            source_addresses      = ["10.1.0.0/16"]
            destination_addresses = ["*"]
            destination_ports     = [443,80]
            protocols             = ["Any"]
        },
    ]  

 application_rule_coll_name     = "Allowed_Internet"
 application_rule_coll_priority = "200"
 application_rule_coll_action   = "Allow"
 application_rules = [   
        {    
            name                  = "Allowed_website_01"
            source_addresses      = ["*"]
            destination_fqdns     = ["*"]
        },
    ]  
 application_protocols = [   
        {    
            type = "Http"
            port = 80
        },
        {
            type = "Https"
            port = 443
        }
    ]
}   
**/

# vpn-gateway Module is used to create VPN Gateway - So that it can connect to the on-prem
module "vpn_gateway" {
source = "./modules/vpn-gateway"
depends_on = [module.hub-vnet , module.spoke-prod-vnet]

vpn_gateway_name              = "az-westeurope-01-vgw"
location                      = module.hub-resourcegroup.rg_location
resource_group_name           = module.hub-resourcegroup.rg_name

type     = "Vpn"
vpn_type = "RouteBased"

sku                           = "VpnGw1"
active_active                 = false
enable_bgp                    = false

ip_configuration              = "default"
private_ip_address_allocation = "Dynamic"
subnet_id                     = module.hub-vnet.vnet_subnet_id[1]
public_ip_address_id          = module.public_ip_01.public_ip_address_id

}

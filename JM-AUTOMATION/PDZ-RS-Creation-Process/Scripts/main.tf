# Check the type of DNS record to be created
locals {
  is_a_record = var.type == "A"
}

# Get existing private DNS zone information
data "azurerm_private_dns_zone" "existing" {
  name                = "digital.matthey.com"
  resource_group_name = "rg-hub-eu-privatedns-001"
}

# Create a new A record set in the fetched private DNS zone
resource "azurerm_private_dns_a_record" "record_a" {
  count               = local.is_a_record ? 1 : 0
  name                = var.name
  zone_name           = data.azurerm_private_dns_zone.existing.name
  resource_group_name = data.azurerm_private_dns_zone.existing.resource_group_name
  ttl                 = var.ttl
  records             = var.ips
}

# Create a new CNAME record set in the fetched private DNS zone
resource "azurerm_private_dns_cname_record" "record_cname" {
  count               = local.is_a_record ? 0 : 1
  name                = var.name
  zone_name           = data.azurerm_private_dns_zone.existing.name
  resource_group_name = data.azurerm_private_dns_zone.existing.resource_group_name
  ttl                 = var.ttl
  record              = var.cname
}

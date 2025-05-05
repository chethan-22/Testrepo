data "azurerm_subscriptions" "available" {}

# Map environment names to subscription IDs
locals {
  key               = "${var.env}-${var.region}"
  subscription_name = lookup(var.configuration, local.key, "")
  lower_case_env_to_subscription_id = {
    for s in data.azurerm_subscriptions.available.subscriptions :
    lower(s.display_name) => s.subscription_id
  }
  subscription_id = local.subscription_name != null ? lookup(local.lower_case_env_to_subscription_id, local.subscription_name, "") : ""
}

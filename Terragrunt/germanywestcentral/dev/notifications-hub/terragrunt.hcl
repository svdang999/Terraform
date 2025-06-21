include {
  # Get global environment variables
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get values from env_dev.hcl file
  env_config          = read_terragrunt_config(find_in_parent_folders("env_dev.hcl"))  
  tags                = local.env_config.locals.tags # can be use as "${local.environment_name}" or local.environment_name
}

# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#retry-configuration
errors {
    retry "azure_errors" {
        retryable_errors = [
          ".*Failed to load state.*",
          ".*Failed to download module.*",
          ".*Failed to query available provider packages.*",
          ".*Error: retrieving account keys for storage account.*",
          ".*Error: getting Storage Account Properties.*",
          ".*could not obtain lease.*",
          ".*socket: connection reset by peer.*",
          ".*HTTP status 429.*",  # Too Many Requests
          ".*network connection reset by peer.*",
          ".*connection refused.*",
          ".*TLS handshake timeout.*",
          ".*ServiceUnavailable.*",
          ".*InternalServerError.*",
          ".*was not found in Active Directory.*",
          ".*http response was nil*.",
          ".*connection may have been reset*."
        ]
        max_attempts = 5                           # Retry up to 5 times
        sleep_interval_sec = 10                    # Wait 10 seconds between retries
    }
}

# terraform {
#   source = "../../../modules/notifications-hub"
# }

# inputs = {
#   namespace_type                            = "NotificationHub"
#   sku_name                                  = "Free"
#   resource_group_name                       = "rg-sondv2"
#   location                                  = "germanywestcentral"
#   name_notification_hub                     = "notihub-abc"  
#   name_namespace_notification_hub           = "notihub-namespace-abc" 
#   name_notification_hub_authorization_rule  = "management-auth-rule"
#   notification_hub_authorization_rule_manage = true
#   notification_hub_authorization_rule_send   = true
#   notification_hub_authorization_rule_listen = true
#   tags                              = local.tags
#   # names                         = [
#   #   "func-splg-intgp-chatbot-processor-dev-ger-01",
#   # ]
# }

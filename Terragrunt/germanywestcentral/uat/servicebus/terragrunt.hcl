include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get Environment name from env_uat.hcl file
  env_config = read_terragrunt_config(find_in_parent_folders("env_uat.hcl"))
  tags              = local.env_config.locals.tags
}

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

terraform {
 source = "../../../modules/servicebus/ver02"
}

inputs = {
  environment                           = "uat"  
  location                              = "germanywestcentral"
  resource_group_name                   = "rg-splg-intgp-common-uat-ger-01"
  resource_group_name_network           = "rg-splg-intgp-network-uat-ger-01"
  servicebus_namespace_name             = "sbns-splg-intgp-uat-ger-01"
  servicebus_sku                        = "Standard"
  
  topics = {
    "topic-splg-intgp-chatbot-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 #must be one of the following values: 1024;2048;3072;4096;5120
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-chatbot-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-chatbot-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-efaa-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-gaca-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-gaca-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-gaca-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-hyper-pay-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-hyper-pay-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-hyper-pay-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-iq-robotics-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-iq-robotics-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-iq-robotics-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-mci-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-mci-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-mci-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-nearpay-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-nearpay-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-nearpay-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-nic-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-nic-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-nic-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-notification-hub-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-notification-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-notification-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-parcel-station-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-parcel-station-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-parcel-station-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-pos-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-pos-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-pos-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-shorting-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-shorting-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-shorting-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-smartbox-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-smartbox-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-smartbox-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-state-security-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-state-security-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-state-security-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-tga-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-tga-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-tga-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-yamamah-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-yamamah-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-yamamah-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }

    "topic-splg-intgp-zatca-uat-ger-01" = {
      partitioning_enabled          = true
      max_size_in_megabytes         = 1024 
      requires_duplicate_detection  = false
      support_ordering              = false

      subscriptions = {
        "sub-splg-intgp-zatca-processor-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
        "sub-splg-intgp-zatca-publisher-uat-ger-01" = {
          max_delivery_count                    = 10
          dead_lettering_on_message_expiration  = false
          enable_batched_operations             = true
          requires_session                      = true
        }
      }
    }
  }
  
  tags = local.tags
}
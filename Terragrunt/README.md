### Terragrunt folder structure
```
terragrunt
├── westeu
├── germanywestcentral
│   └── platform
│       ├── env-dev
│       │   ├── service-a
│       │   │   └── terragrunt.hcl
│       │   ├── service-b
│       │   └── service-c
│       ├── env-uat
│       └── env-prd
├── modules
│   ├── service-a
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   └── variables.tf
│   ├── service-b
│   └── service-c
└── tests
    ├── 01_dev    
    ├── 02_uat
    │   ├── go.mod
    │   ├── go.sum
    │   └── module_test.go
    └── 03_prd
```

### DBP Terragrunt Architecture
https://infinitepl.atlassian.net/wiki/spaces/DBP/pages/446038039/DBP+Terragrunt+structure

Terragrunt folder structure will be divide to 3 main folders 
```
- region: location where Terragrunt provisioning IAC services.
- modules: Folder contains services types for re-usable infrastructure accross all projects.
- tests: Terratest Unit-test codes.
```

Terragrunt Modules
=====================================

## Information:

Terragrunt Modules to create single resource or all resources in platforms dev/uat/prod. 

### Case1:
  Run all resources provisioning. 
### Case2:
  Run single resource provisioning.

## Case usage: define service's configurations for Terragrunt 

terragrunt.hcl
```hcl
include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get Environment name from env_uat.hcl file
  env_config = read_terragrunt_config(find_in_parent_folders("env_uat.hcl"))
  tags              = local.env_config.locals.tags
}

terraform {
 source = "../../../../modules/identity"
}

inputs = {
 identity_name             = "id-splg-intgp-uat-ger-abcd"
 resource_group_name       = "rg-splg-intgp-common-uat-ger-01"
 location                  = "Germany West Central"
 tags                      = local.tags
}
```

## Review & Apply the module
For single resource provision
```
terragrunt run plan
terragrunt run apply
```

For all resources provision
```
terragrunt run-all plan
terragrunt run-all apply
```

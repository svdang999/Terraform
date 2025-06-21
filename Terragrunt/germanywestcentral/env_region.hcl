# Set common variables for the region. This is automatically pulled in in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  az_project        = "dbp"
  az_environment    = "integration"
  az_region         = "germanywestcentral"
  az_deployment     = "intgp"  
}
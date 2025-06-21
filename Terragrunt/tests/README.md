## Introdution
This Terratest module create Integration tests for Terragrunt. 

- Instructions for running each Terratest module are included in each tests environment sub-folder:
```
tests/<02_uat>/README.md
```

- Tests which assert against expected Terraform output values are located in the the respective go files of the folder:
```
tests/02_uat/<service_name>_test.go
```

In order to run the Terratest, test file must be end with "_test.go" format. For example:
```
appcfg_test.go
identity_test.go
```


## Usage
1. Create test module file
module_test.go
```
package test 

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)


// define terraform directory to test
var terraformParentDir string = "../../germanywestcentral/integration/uat"


func TestIdentity(t *testing.T) {
  t.Parallel()

  // Construct the terraform options setting the path to the Terraform code we want to test and and specifying the terragrunt binary.
  terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: terraformParentDir,
    TerraformBinary: "terragrunt",
  })
  
  // At the end of the test, run `terragrunt run-all destroy` to clean up any resources that were created.
  defer terraform.TgDestroyAll(t, terraformOptions) // terragrunt run-all destroy

  // Run `terragrunt run-all apply`. Fail the test if there are any errors.
  terraform.TgApplyAll(t, terraformOptions)  // 

  // Identity service tests
  identity_name           := getOutput(t, terraformOptions, "/identity", "identity_name")
  location                := getOutput(t, terraformOptions, "/identity", "location")
  resource_group_name     := getOutput(t, terraformOptions, "/identity", "resource_group_name")

  assert.Equal(t, "id-splg-intgp-uat-ger-abcd", identity_name)
  assert.Equal(t, "Germany West Central", location)
  assert.Equal(t, "rg-splg-intgp-common-uat-ger-01", resource_group_name) 
}
```

2. Run go command to initialize the test modules
```
go mod init module_test.go && go mod tidy
```

3. Run the test 
```
go test -v
```

## Security - how to upgrade/patch go package

Issue: Github security alerts 
```
https://github.com/SaudiPostLogisticsGroup/dbp-integration-platform-iac/security/dependabot/3

Upgrade golang.org/x/net to fix 2 Dependabot alerts in uat/storage/tests/go.mod
Upgrade golang.org/x/net to version 0.38.0 or later. 
```

## Solution
1. Upgrade vulnerability packages to patched version in go.mod

```hcl
go.mod
golang.org/x/net v0.38.0
```

2. Upgrade missed packages after patched security & rerun the test
```
go test -v
# module_test.go
C:\Users\xxx\go\pkg\mod\github.com\gruntwork-io\terratest@v0.48.2\modules\retry\retry.go:13:2: missing go.sum entry for module providing package golang.org/x/net/context (imported by github.com/gruntwork-io/terratest/modules/retry); to add:
        go get github.com/gruntwork-io/terratest/modules/retry@v0.48.2
FAIL    module_test.go [setup failed]
```

```
go get github.com/gruntwork-io/terratest/modules/retry@v0.48.2
go test -v
```



// ref: https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/terraform
// ref: https://www.linkedin.com/pulse/testing-iac-using-terratest-ed-oatley-4arje
package test 

import (
	"testing"

	// "github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)


// define terraform directory to test
var terraformParentDir string = "../../germanywestcentral/dev"


func TestConfigurations(t *testing.T) {
  t.Parallel()

  // Construct the terraform options setting the path to the Terraform code we want to test and and specifying the terragrunt binary.
  terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: terraformParentDir,
    TerraformBinary: "terragrunt",
  })
  
  // At the end of the test, run `terragrunt run-all destroy` to clean up any resources that were created.
  // defer terraform.TgDestroyAll(t, terraformOptions) // terragrunt run-all destroy

  // Run `terragrunt run-all apply`. Fail the test if there are any errors.
  // terraform.TgApplyAll(t, terraformOptions)  // 
  terraform.TgPlanAllExitCode(t, terraformOptions) //run-all plan

  //Identity
  location_identity                := getOutput(t, terraformOptions, "/identity", "location")
  resource_group_name_identity     := getOutput(t, terraformOptions, "/identity", "resource_group_name")

  assert.Equal(t, "Germany West Central", location_identity)
  assert.Equal(t, "rg-splg-intgp-common-dev-ger-01", resource_group_name_identity)

  //Key vault
  location_keyvault                := getOutput(t, terraformOptions, "/keyvault", "location")
  resource_group_name_keyvault     := getOutput(t, terraformOptions, "/keyvault", "resource_group_name")

  assert.Equal(t, "Germany West Central", location_keyvault)
  assert.Equal(t, "rg-splg-intgp-common-dev-ger-01", resource_group_name_keyvault)

}

// helper function to simplify fetching the outputs when using terragrunt run-all
func getOutput(t *testing.T, terraformOptions *terraform.Options, dir string, output string) string {
  terraformOptions.TerraformDir = terraformParentDir + dir
  outputValue := terraform.Output(t, terraformOptions, output)
  terraformOptions.TerraformDir = terraformParentDir
  return outputValue
}        
// ref: https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/terraform
// ref: https://www.linkedin.com/pulse/testing-iac-using-terratest-ed-oatley-4arje
package test 

import (
	"testing"

	// "github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)


// directory run tests
var terraformParentDir string = "../../germanywestcentral/uat"


func TestConfigurations(t *testing.T) {
  t.Parallel()

  // Construct the terraform options setting the path to the Terraform code we want to test and and specifying the terragrunt binary.
  terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: terraformParentDir,
    TerraformBinary: "terragrunt",
  })

  output := terraform.TgPlanAllExitCode(t, terraformOptions) //run-all plan https://github.com/gruntwork-io/terratest/blob/main/modules/terraform/plan.go
  
  //asserts the success (or failure) of a terragrunt run-all plan
  terraform.AssertTgPlanAllExitCode(t, output, true) 

  // Assert Identity service outputs - resource must exists 
  resource_group_name     := getOutput(t, terraformOptions, "/identity", "resource_group_name")

  assert.Equal(t, "rg-splg-intgp-common-uat-ger-01", resource_group_name)

}

// helper function to simplify fetching the outputs when using terragrunt run-all
func getOutput(t *testing.T, terraformOptions *terraform.Options, dir string, output string) string {
  terraformOptions.TerraformDir = terraformParentDir + dir
  outputValue := terraform.Output(t, terraformOptions, output)
  terraformOptions.TerraformDir = terraformParentDir
  return outputValue
}        
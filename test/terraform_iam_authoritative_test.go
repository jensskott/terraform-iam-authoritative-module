package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type M map[string]interface{}

func TestTerraformHelloWorldExample(t *testing.T) {
	var roles []M
	roles = append(roles, M{
		"role":    "roles/run.invoker",
		"members": []string{"group:test-group@example.com", "user:test-user@example.com"},
	}, M{
		"role":    "roles/run.invoker",
		"members": []string{"group:test-group2@example.com", "user:test-user2@example.com"},
	})

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"roles": roles,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	output := terraform.Output(t, terraformOptions, "iam_roles")
	assert.Equal(t, []M{{"role": "roles/run.invoker", "members": []string{"group:test-group@example.com", "user:test-user@example.com", "group:test-group2@example.com", "user:test-user2@example.com"}}}, output)
}

# Should use the local variables to merge the different role members into one and output them together in a list
locals {
  roles = [
  ]
}

# Output of roles, should b e a list of roles
# [{role: roles/run.invoker, members: [test@example.com]}]
output "iam_roles" {
  value = var.roles
}

# A list of objects with the role and members, needs to be a list since the input can contain multiple entries of the
# same role and members needs to be merged before returning the output.
variable "roles" {
  type = list(object({
    role    = string
    members = list(string)
  }))
  default = []

  description = <<-EOT
  Input for the roles, the roles should be defined in a list of objects like:
  [
    {
      "role" = "roles/invoker.run",
      "members" = ["group:test-group@example.com"]
    },
    {
      "role" = "roles/invoker.run",
      "members" = ["user:test-user@example.com"]
    }
  ]

  The members list supports:
  * user:{emailid}: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
  * serviceAccount:{emailid}: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
  * group:{emailid}: An email address that represents a Google group. For example, admins@example.com.
  * domain:{domain}: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
  EOT
}
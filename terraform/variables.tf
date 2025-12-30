# variable "accountId" {
#   type        = number
#   default     = 887174924057
#   description = "account ID"
# }

variable "assume_role_name" {
  type        = string
  default     = "TerraformDeployRole"
  description = "assume role name"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}
variable "db_password" {
  type      = string
  sensitive = true
  default   = "India1234"
}

variable "restored_db_endpoint" {
  type    = string
  default = ""
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))

  default = {
    private-a = {
      cidr = "10.0.10.0/24"
      az   = "us-east-1a"
    }
    private-b = {
      cidr = "10.0.11.0/24"
      az   = "us-east-1b"
    }
  }
}

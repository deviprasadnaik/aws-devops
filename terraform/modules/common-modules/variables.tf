# variable "bucketName" {}

# variable "lambdaArn" {}

variable "ec2_subnet_id" {
  default = ""
}

variable "enable_ec2" {
  type    = string
  default = "false"
}

variable "vpc_id" {
  default = ""
}

variable "enable_ec2_role" {default = false}

variable "enable_attachment" {default = false}

variable "enable_s3" {default = false}

variable "appName" {
  default = ""
}

variable "cwName" {
  type    = string
  default = null
}
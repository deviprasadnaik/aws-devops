locals {
  # bucket_map = var.bucketName != "" ? { "${var.bucketName}" = true } : {}
  ec2_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
}

resource "random_string" "this" {
  length  = 5
  numeric = true
  special = false
  upper   = false
}
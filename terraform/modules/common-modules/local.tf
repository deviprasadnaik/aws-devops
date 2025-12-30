locals {
  # bucket_map = var.bucketName != "" ? { "${var.bucketName}" = true } : {}
  ec2_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
}
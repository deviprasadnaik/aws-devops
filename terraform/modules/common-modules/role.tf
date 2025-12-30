resource "aws_iam_role" "this" {
  for_each = var.enable_ec2 ? { create = true } : {}
  name     = "EC2InstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.enable_ec2 ? toset(local.ec2_policies) : toset([])

  role       = aws_iam_role.this["create"].name
  policy_arn = each.key
}
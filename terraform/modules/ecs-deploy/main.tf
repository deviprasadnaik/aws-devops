module "common-modules" {
  source = "../common-modules"
  enable_ec2_role = true
  enable_attachment = true
  appName=var.appName
  # enable_s3 = true
  cwName = "/ecs/${var.appName}"
}


resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(local.ecs_permissions)

  role       = module.common-modules.roleName
  policy_arn = each.value
}

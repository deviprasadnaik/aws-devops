resource "aws_iam_role" "codeBuildRole" {
  name = "codebuild-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codeBuildPolicy" {
  for_each   = toset(local.codebuild_policies)
  role       = aws_iam_role.codeBuildRole.name
  policy_arn = each.key
}

resource "aws_iam_role" "ec2CodedeployRole" {
  name = var.ec2_instance_role

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

resource "aws_iam_role_policy_attachment" "ec2CodedeployPolicy" {
  for_each   = toset(local.ec2_policies)
  role       = aws_iam_role.ec2CodedeployRole.name
  policy_arn = each.key
}

resource "aws_iam_role" "codeDeployRole" {
  name = var.codedeploy_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codeDeployPolicy" {
  for_each   = toset(local.codedeploy_policies)
  role       = aws_iam_role.codeDeployRole.name
  policy_arn = each.key
}

resource "aws_iam_role" "codePipelineRole" {
  name = var.codepipeline_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codePipelinePolicy" {
  for_each   = toset(local.codepipeline_policies)
  role       = aws_iam_role.codePipelineRole.name
  policy_arn = each.key
}


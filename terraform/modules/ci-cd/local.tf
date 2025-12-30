locals {
  codebuild_policies = [
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
  ec2_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
  codedeploy_policies = [
    "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  ]
  codepipeline_policies = [
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"

  ]
}

resource "random_string" "this" {
  length  = 5
  numeric = true
  special = false
  upper   = false
}
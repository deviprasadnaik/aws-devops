resource "aws_codebuild_project" "this" {
  name         = "${var.appName}-build"
  description  = "Build project for Java application"
  service_role = aws_iam_role.codeBuildRole.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # environment_variable {
    #   name  = "ENV"
    #   value = "dev"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/app-build"
      stream_name = "build-log"
    }
  }
}

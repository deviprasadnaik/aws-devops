resource "aws_codepipeline" "this" {
  name     = "${var.appName}-pipeline"
  role_arn = aws_iam_role.codePipelineRole.arn

  artifact_store {
    location = aws_s3_bucket.this.bucket
    type     = "S3"
  }

  # ------------------
  # SOURCE STAGE
  # ------------------
  stage {
    name = "Source"

    action {
      name             = "S3Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        S3Bucket             = aws_s3_bucket.this.bucket
        S3ObjectKey          = "java.zip"
        PollForSourceChanges = "true"
      }
    }
  }

  # ------------------
  # BUILD STAGE
  # ------------------
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }
    }
  }

  # ------------------
  # DEPLOY STAGE
  # ------------------
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName     = aws_codedeploy_app.this.name
        DeploymentGroupName = aws_codedeploy_deployment_group.this.deployment_group_name
      }
    }
  }
}

module "ci-cd-pipeline" {
  source            = "./modules/ci-cd"
  vpc_id            = data.aws_vpc.default.id
  ec2_instance_role = "EC2InstanceRole"
  appName           = "java-app"
  codepipeline_role = "CodePipelineServiceRole"
  codedeploy_role   = "CodeDeployRole"
}

# module "event-driven" {
#   source     = "./modules/event-driven"
#   bucketName = "kodekloud-test-bk"
# }

# module "multi-az-db" {
#   source = "./modules/multi-az-db"
# }
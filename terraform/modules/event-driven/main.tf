module "event-driven" {
  source     = "../common-modules"
  bucketName = var.bucketName
  lambdaArn  = aws_lambda_function.this.arn
}
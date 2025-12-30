resource "aws_cloudtrail" "this" {
  name                          = "KodeKloud-cloudtrail"
  s3_bucket_name                = module.event-driven.bucketName
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
}
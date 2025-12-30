# resource "aws_s3_bucket" "this" {
#   for_each = local.bucket_map
#   bucket   = each.key
# }

# resource "aws_s3_bucket_policy" "this" {
#   bucket = values(aws_s3_bucket.this)[0].id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "AWSCloudTrailAclCheck"
#         Effect    = "Allow"
#         Principal = { Service = "cloudtrail.amazonaws.com" }
#         Action    = "s3:GetBucketAcl"
#         Resource  = values(aws_s3_bucket.this)[0].arn
#       },
#       {
#         Sid       = "AWSCloudTrailWrite"
#         Effect    = "Allow"
#         Principal = { Service = "cloudtrail.amazonaws.com" }
#         Action    = "s3:PutObject"
#         Resource  = "${values(aws_s3_bucket.this)[0].arn}/AWSLogs/*"
#         Condition = {
#           StringEquals = {
#             "s3:x-amz-acl" = "bucket-owner-full-control"
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_s3_bucket_notification" "this" {
#   bucket = values(aws_s3_bucket.this)[0].id

#   lambda_function {
#     lambda_function_arn = var.lambdaArn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "incoming/"
#     filter_suffix       = ".json"
#   }

#   # depends_on = [aws_lambda_permission.allow_s3]
# }

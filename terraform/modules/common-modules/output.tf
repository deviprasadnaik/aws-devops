# output "bucketName" {
#   value = values(aws_s3_bucket.this)[0].bucket
# }

# output "bucketArn" {
#   value = values(aws_s3_bucket.this)[0].arn
# }

output "roleName" {
  value = aws_iam_role.this["create"].name
}

output "defaultVpc" {
  value = data.aws_vpc.this.id
}

output "amiID" {
  value = data.aws_ami.this.id
}

output "cwName" {
  value = aws_cloudwatch_log_group.this["create"].name
}
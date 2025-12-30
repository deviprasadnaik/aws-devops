
resource "aws_lambda_permission" "this" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.event-driven.bucketArn
}

resource "aws_lambda_function" "this" {
  function_name = "s3-event-handler"
  # role          = "arn:aws:iam::521645453977:role/lambda-exec"
  role    = aws_iam_role.this.arn
  handler = "index.handler"
  runtime = "python3.12"

  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256

  # lifecycle {
  #   ignore_changes = [
  #     role
  #   ]
  # }

}


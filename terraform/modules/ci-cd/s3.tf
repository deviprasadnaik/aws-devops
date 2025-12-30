resource "aws_s3_bucket" "this" {
  bucket = "s3-${var.appName}-${random_string.this.result}"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.id
  key    = "java.zip"
  source = data.archive_file.this.output_path

  etag = filemd5(data.archive_file.this.output_path)
}


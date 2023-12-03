resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket

  tags = {
    Environment = var.environment
    Terraform = "yes"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_bucket.id

  lambda_function {
    lambda_function_arn = module.lambda.lambda_function_arn
    events = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.lambda_function]
}

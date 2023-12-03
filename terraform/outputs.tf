output "s3_bucket_name" {
  description = "ARN of the s3 bucket"
  value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the s3 bucket"
  value = aws_s3_bucket.s3_bucket.arn
}

output "dynabodb_table_arn" {
  description = "ARN of the dynamodb table"
  value = aws_dynamodb_table.dynamodb_table.arn
}

output "step_function_arn" {
  description = "ARN of the dynamodb table"
  value = module.step_function.state_machine_arn
}

output "lambda_function_arn" {
  description = "ARN of the dynamodb table"
  value = module.lambda.lambda_function_arn
}

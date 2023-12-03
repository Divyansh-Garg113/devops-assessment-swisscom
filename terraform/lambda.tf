locals {
    function_name = "execute-stepfunction"
    iam_polciy_step_function = "lambda-invoke-step-function-policy"
}

module "lambda" {
  source = "registry.terraform.io/terraform-aws-modules/lambda/aws"
  version = "3.2.1"
  description = "AWS Lambda function triggered by S3:CreateObject to invoke step function"
  function_name = local.function_name

  handler = "main.lambda_handler"
  runtime = "python3.9"
  timeout = 30

  architectures = ["arm64"] // is cheaper.
  recreate_missing_package = false // Else the zip is recreated every apply even if nothing changed.

  attach_policy = true
  policy = aws_iam_policy.lambda_stepfunctions_policy.arn

  assume_role_policy_statements = {
    statement = {
      effect = "Allow",
      actions = ["sts:AssumeRole"],
      principals = {
        account_principal = {
          type = "SERVICE"
          identifiers = ["states.amazonaws.com"]
        }
      }
    }
  } 

  source_path = "src/main.py"

  tags = {
    Environment = var.environment
    Terraform = "yes"
  }

  environment_variables = {
      step_function_arn = module.step_function.state_machine_arn
  }
}


resource "aws_iam_policy" "lambda_stepfunctions_policy" {
  name = local.iam_polciy_step_function
  path = "/"
  description = "IAM policy to allow Lambda function to invoke Step function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "states:StartExecution",
        ]
        Effect   = "Allow"
        Resource = module.step_function.state_machine_arn
      },
    ]
  })
}

resource "aws_lambda_permission" "lambda_function" {
  statement_id  = "AllowS3Invoke"
  action = "lambda:InvokeFunction"
  function_name = local.function_name
  principal = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.s3_bucket.arn
}

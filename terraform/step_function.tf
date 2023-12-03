

locals {
    definition_template = <<EOF
        {
        "Comment": "Add S3 object name to DynamoDB Files table under the FileName attribute",
        "StartAt": "Update",
        "States": {
            "Update": {
            "Type": "Task",
            "Resource": "arn:aws:states:::dynamodb:putItem",
            "Parameters": {
                "TableName": "Files",
                "Item":{
                    "FileName":{
                        "S.$":"$.file_name"
                    }
                }
            },
            "End": true
            }
        }
    }
    EOF
}

module "step_function" {
  source = "terraform-aws-modules/step-functions/aws"
  version = "4.0.0"

  name = var.step_function
  definition = local.definition_template

  service_integrations = {
    dynamodb = {
      dynamodb = [aws_dynamodb_table.dynamodb_table.arn]
    }
  }

  type = "STANDARD"

  tags = {
    Environment = var.environment
    Terraform = "yes"
  }
}

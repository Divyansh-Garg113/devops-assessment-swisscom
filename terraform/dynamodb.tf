resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.dynamodb_table
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.dynamodb_attribute
  
  attribute {
    name = var.dynamodb_attribute
    type = "S"
  }

  tags = {
    Environment = var.environment
    Terraform = "yes"
  }
}
variable "bucket" {
    description = "Name of the s3 bucket"
    type = string
    default = "test-bucket"
}

variable "environment" {
    description = "Defines the environment of aws infrastructure"
    type = string
    default = "localstack"
}

variable "dynamodb_table" {
    description = "Name of dynamodb table"
    type = string
    default = "Files"
}

variable "dynamodb_attribute" {
    description = "dynamodb table attribute"
    type = string
    default = "FileName"
}

variable "step_function" {
    description = "Name of step function"
    type = string
    default = "update_dynamodb_table"
}
# Files created to solve the assignment
- dynamodb.tf
    - contains terraform configurations for dynamodb table `Files` with an attribute `Filename`

- lambda.tf
    - terraform configurations for creating lambda function using aws lambda module.
    - IAM policy to execute step function.
    - IAM permissions to allow s3 bucket to invoke the lambda function.

- src/main.py
    - A python lambda function which gets executed when lambda is invoked by s3.
    - python libraries used -  json, os and boto3 sdk for aws.

- s3.tf
    - configurations to create an s3 bucket
    - terraform resource to configure s3 bucket event notification for lambda invoke

- step_function.tf
    - configuration to create step function
    - service integrations block allows terraform to create appropriate aws resources for updating dynamodb table

- variables.tf
    - variables to be used by different resources

- outputs.tf
    - Provide ARNs of the resources on CLI

- backend.tf
    - backend configuration for terraform to store the state locally in terraform.tfstate file.

# machine on which the code is tested successfully
    - MaxOS 14.1.1

# Changes made to execute the assignment

I have updated the localstack image tag to "latest" in docker-compose.yml. The reason I had to change the image tag is that localstack was not able to create statefunction resource due to a bug with the provider. However, updating the image tag resolved the issue. The code is executing as expected on macos terminal.
Moreover, to execute the assignment on linux, please feel free to change the localstack image tag back to 1.3.1. However, the same is not tested on linux with tag 1.3.1.

import boto3
import json
import os

step_function_arn = os.environ.get('step_function_arn')

def lambda_handler(event, context):
    s3_file_name = event['Records'][0]['s3']['object']['key']
    stepfunctions = boto3.client('stepfunctions', endpoint_url='http://host.docker.internal:4566', region_name='eu-central-1')

    # Input for Step Function workflow
    step_input = {
        "file_name": s3_file_name
    }
    
    execute_step_function = stepfunctions.start_execution(
        stateMachineArn = step_function_arn,
        input = json.dumps(step_input)
    )
    print(execute_step_function)

    return {
        'statusCode': 200,
        'body': json.dumps('Step Functions workflow started successfully!')
    }

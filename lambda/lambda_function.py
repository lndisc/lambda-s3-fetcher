import boto3
import json

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    
    bucket_name = event['bucket_name']
    object_key = event['object_key']

    try:
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response['Body'].read().decode('utf-8')
        return {
            'statusCode': 200,
            'body': content
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': str(e)
        }

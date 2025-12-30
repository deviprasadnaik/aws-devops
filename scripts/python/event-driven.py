data = {'Records': [{'eventVersion': '2.1', 'eventSource': 'aws:s3', 'awsRegion': 'us-east-1', 'eventTime': '2025-12-11T12:50:59.074Z', 'eventName': 'ObjectCreated:Put', 'userIdentity': {'principalId': 'AWS:AROAI2LRE6HOGRN3IWEKI:regionalDeliverySession'}, 'requestParameters': {'sourceIPAddress': '52.24.133.163'}, 'responseElements': {'x-amz-request-id': '9WY584JMY2NADY2C', 'x-amz-id-2': 'bv2sO44W/qN21xjHBoEaj9hPzLdYnR3UtPoHAh3VHUnOD8+y35EWX7mihQVZMwVkbnWzwk1PT9WzjqdZL/2BIX13ibt+5Ia+'}, 's3': {'s3SchemaVersion': '1.0', 'configurationId': 'log-parser', 'bucket': {'name': 'aws-cloudtrail-logs-718633645857-86ffa7df', 'ownerIdentity': {'principalId': 'A1LTUPKDWDZAC6'}, 'arn': 'arn:aws:s3:::aws-cloudtrail-logs-718633645857-86ffa7df'}, 'object': {'key': 'AWSLogs/718633645857/CloudTrail/us-west-2/2025/12/11/718633645857_CloudTrail_us-west-2_20251211T1250Z_UidgAgQekcWiqMu6.json.gz', 'size': 920, 'eTag': '1e70e3c3e72743df15839746ad32c14c', 'sequencer': '00693ABE32F4DCA8AE'}}}]}

bucketName=data['Records'][0]['s3']['bucket']['name']

import json
import boto3 
import gzip

s3 = boto3.client('s3')

def lambda_handler(event, context):
    record = event['Records'][0]
    bucket = record['s3']['bucket']['name']
    key    = record['s3']['object']['key']

    response = s3.get_object(Bucket=bucket, Key=key)
    body = response['Body'].read()

    if key.endswith(".gz"):
        body = gzip.decompress(body)

        print(json.loads(body))
    

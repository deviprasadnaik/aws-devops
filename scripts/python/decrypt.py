import boto3
import os
from dotenv import load_dotenv

load_dotenv()
aws_access_key = os.getenv("AWS_ACCESS_KEY")
aws_secret_key = os.getenv("AWS_SECRET_KEY")

def create_session():
    """
    Creates and returns a boto3 session.
    """
    return boto3.session.Session(
        aws_access_key_id=aws_access_key,
        aws_secret_access_key=aws_secret_key,
        aws_session_token = None,
        region_name="us-east-1"
    )

def create_kms_client(session):
    return session.client("kms")

def encrypt_data(kms_client, key_id, plaintext_bytes):
    response = kms_client.encrypt(
        KeyId=key_id,
        Plaintext=plaintext_bytes
    )
    return response

# Usage
aws_session = create_session()
kms_client = create_kms_client(aws_session)
plaintext = "MySecretData"
key_id = "a8436a42-7759-4dbd-9ed3-21a31ac328f5"

encrypted_response = encrypt_data(kms_client, key_id, plaintext)
print(encrypted_response)

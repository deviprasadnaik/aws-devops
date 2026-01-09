from dotenv import load_dotenv
import urllib3
import json
import os
import base64
from nacl import public

load_dotenv()

AWS_REGION = os.getenv("AWS_REGION")
ECR_REPOSITORY = os.getenv("ECR_REPOSITORY")
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
OWNER = os.getenv("OWNER")
REPO = os.getenv("REPO")
S3_BUCKET=os.getenv("S3_BUCKET")
AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_ACCOUNT_ID = os.getenv("AWS_ACCOUNT_ID")
TASK_DEF_FAMILY=os.getenv("TASK_DEF_FAMILY")
APP_NAME=os.getenv("APP_NAME")
DG_NAME=os.getenv("DG_NAME")

url = f"https://api.github.com/repos/{OWNER}/{REPO}/actions/secrets"

SECRETS = {
    "AWS_REGION": AWS_REGION,
    "ECR_REPOSITORY": ECR_REPOSITORY,
    "S3_BUCKET": S3_BUCKET,
    "AWS_ACCESS_KEY_ID": AWS_ACCESS_KEY_ID,
    "AWS_SECRET_ACCESS_KEY": AWS_SECRET_ACCESS_KEY,
    "AWS_ACCOUNT_ID": AWS_ACCOUNT_ID
}

required_vars = {
    "GITHUB_TOKEN": GITHUB_TOKEN,
    "OWNER": OWNER,
    "REPO": REPO
}

missing = [k for k, v in required_vars.items() if not v]
if missing:
    raise RuntimeError(f"Missing required environment variables: {missing}")

HEADERS = {
    "Authorization": f"Bearer {GITHUB_TOKEN}",
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
}

http = urllib3.PoolManager()

key_url = f"https://api.github.com/repos/{OWNER}/{REPO}/actions/secrets/public-key"

key_response = http.request("GET", key_url, headers=HEADERS)

if key_response.status != 200:
    raise RuntimeError(
        f"Failed to fetch public key: {key_response.status} "
        f"{key_response.data.decode()}"
    )

key_data = json.loads(key_response.data.decode())
public_key = key_data["key"]
key_id = key_data["key_id"]

def encrypt_secret(repo_public_key: str, secret_value: str) -> str:
    public_key_bytes = base64.b64decode(repo_public_key)
    sealed_box = public.SealedBox(public.PublicKey(public_key_bytes))
    encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
    return base64.b64encode(encrypted).decode("utf-8")

SECRETS = {
    "AWS_REGION": AWS_REGION,
    "ECR_REPOSITORY": ECR_REPOSITORY,
    "S3_BUCKET": S3_BUCKET,
    "AWS_ACCESS_KEY_ID": AWS_ACCESS_KEY_ID,
    "AWS_SECRET_ACCESS_KEY": AWS_SECRET_ACCESS_KEY,
    "AWS_ACCOUNT_ID": AWS_ACCOUNT_ID,
    "TASK_DEF_FAMILY": TASK_DEF_FAMILY,
    "APP_NAME": APP_NAME,
    "DG_NAME": DG_NAME,
}

for secret_name, secret_value in SECRETS.items():

    if not secret_value:
        print(f"Skipping {secret_name} (empty value)")
        continue

    encrypted_value = encrypt_secret(public_key, secret_value)

    secret_url = (
        f"https://api.github.com/repos/{OWNER}/{REPO}"
        f"/actions/secrets/{secret_name}"
    )

    payload = {
        "encrypted_value": encrypted_value,
        "key_id": key_id
    }

    response = http.request(
        "PUT",
        secret_url,
        headers=HEADERS,
        body=json.dumps(payload)
    )

    if response.status in (201, 204):
        print(f"{secret_name} updated successfully")
    else:
        print(f"Failed to update {secret_name}")
        print(response.status, response.data.decode())

print("Secret sync completed")



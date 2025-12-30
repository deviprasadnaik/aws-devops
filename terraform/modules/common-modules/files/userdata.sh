#!/bin/bash
set -xe

# Update system
yum update -y

# Start and enable amazon ssm agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
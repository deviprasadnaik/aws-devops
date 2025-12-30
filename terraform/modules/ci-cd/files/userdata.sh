#!/bin/bash
set -xe

# Update system
yum update -y

# Install CodeDeploy agent dependencies
yum install -y ruby wget

# Download and install CodeDeploy agent
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x install
./install auto

# Install java 
yum install -y java-17-amazon-corretto

# Start and enable CodeDeploy agent
systemctl start codedeploy-agent
systemctl enable codedeploy-agent

# Start and enable amazon ssm agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
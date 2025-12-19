#!/bin/bash
set -e

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=ap-south-1
ECR_URL=$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

aws ecr create-repository --repository-name kafka || true
aws ecr create-repository --repository-name kafka-connect || true

aws ecr get-login-password --region $REGION | \
docker login --username AWS --password-stdin $ECR_URL

docker build -t kafka docker/kafka
docker tag kafka:latest $ECR_URL/kafka:latest
docker push $ECR_URL/kafka:latest

docker build -t kafka-connect docker/kafka-connect
docker tag kafka-connect:latest $ECR_URL/kafka-connect:latest
docker push $ECR_URL/kafka-connect:latest

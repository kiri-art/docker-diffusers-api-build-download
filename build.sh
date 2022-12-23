#!/bin/sh

DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=plain \
  docker build -t diffusers-api \
  --build-arg http_proxy="http://172.17.0.1:3128" \
  --build-arg https_proxy="http://172.17.0.1:3128" \
  --build-arg HF_AUTH_TOKEN="$HF_AUTH_TOKEN" \
  --build-arg AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
  --build-arg AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
  --build-arg AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION" \
  --build-arg AWS_S3_DEFAULT_BUCKET="$AWS_S3_DEFAULT_BUCKET" \
  --build-arg AWS_S3_ENDPOINT_URL="$AWS_S3_ENDPOINT_URL" \
  "$@" .

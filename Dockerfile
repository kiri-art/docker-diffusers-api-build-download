# Unlikely you'll ever want to change this.
ARG FROM_IMAGE="gadicc/diffusers-api"
FROM ${FROM_IMAGE} as base
ENV FROM_IMAGE=${FROM_IMAGE}

# Model id, precision, etc.
ARG MODEL_ID="stabilityai/stable-diffusion-2-1-base"
ENV MODEL_ID=${MODEL_ID}
ARG PRECISION="fp16"
ENV PRECISION=${PRECISION}
ARG PIPELINE="ALL"
ENV PIPELINE=${PIPELINE}
ARG MODEL_URL="s3://"
ENV MODEL_URL=${MODEL_URL}

# To use a .ckpt file, put the details here.
ARG CHECKPOINT_URL=""
ENV CHECKPOINT_URL=${CHECKPOINT_URL}
ARG CHECKPOINT_CONFIG_URL=""
ENV CHECKPOINT_CONFIG_URL=${CHECKPOINT_CONFIG_URL}

# AWS / S3-compatible storage (see docs)
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
# AWS, use "us-west-1" for banana; leave blank for Cloudflare R2.
ARG AWS_DEFAULT_REGION
ARG AWS_S3_DEFAULT_BUCKET
# Only if your non-AWS S3-compatible provider told you exactly what
# to put here (e.g. for Cloudflare R2, etc.)
ARG AWS_S3_ENDPOINT_URL

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
ENV AWS_S3_DEFAULT_BUCKET=${AWS_S3_DEFAULT_BUCKET}
ENV AWS_S3_ENDPOINT_URL=${AWS_S3_ENDPOINT_URL}

# Download the model
ENV RUNTIME_DOWNLOADS=0
RUN python3 download.py

# Send (optionally signed) status updates to a REST endpoint
ARG SEND_URL
ENV SEND_URL=${SEND_URL}
ARG SIGN_KEY
ENV SIGN_KEY=${SIGN_KEY}

# Override only if you know you need to turn this off
ARG SAFETENSORS_FAST_GPU=1
ENV SAFETENSORS_FAST_GPU=${SAFETENSORS_FAST_GPU}

CMD python3 -u server.py

#!/bin/bash

set -x

# Set kubeconfig path to make kubectl work inside pipeline
#export KUBECONFIG=/home/azureuser/.kube/config

# Set your Azure DevOps repository URL with access token (replace with your actual URL and token)
REPO_URL="https://<AZ PAT>@dev.azure.com/Organisation09/calculator/_git/calculator"

REPO_NAME=$(basename "$REPO_URL" | sed 's/.git$//')

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

docker run --privileged --rm tonistiigi/binfmt --install all

# Create a buildx builder instance if not already exists
docker buildx create --name multiarch-builder --use || echo "builder exists"
docker buildx inspect --bootstrap

# The app name (calculator), Docker registry, and image tag are passed as parameters
#APP_NAME="calculator"
ACR_NAME="devopsproject.azurecr.io"      # e.g. devopsproject.azurecr.io
IMAGE_TAG="183"     # e.g. 45

# Build and push multi-architecture Docker image
docker buildx build --platform linux/arm64,linux/amd64 -t ${ACR_NAME}/${REPO_NAME}:${IMAGE_TAG} --push .


# Update the image tag in deployment.yaml
sed -i "s|image:.*|image: ${ACR_NAME}/${REPO_NAME}:${IMAGE_TAG}|g" k8s-specifications/deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push

# Cleanup
rm -rf /tmp/temp_repo

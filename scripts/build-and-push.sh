#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DOCKER_DEFAULT_PLATFORM="linux/amd64"
IMAGE_NAMESPACE="registry.gitlab.com/etalab/data.gouv.fr/infra"
IMAGE_NAME="docker-ansible-git-crypt"
IMAGE_VERSION="python3.12.2-ansible9.3.0-docker27.3.1-$(git rev-parse --short HEAD)"

docker build -t $IMAGE_NAMESPACE/$IMAGE_NAME:$IMAGE_VERSION .
docker push $IMAGE_NAMESPACE/$IMAGE_NAME:$IMAGE_VERSION

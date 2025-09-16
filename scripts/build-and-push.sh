#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DOCKER_DEFAULT_PLATFORM="linux/amd64"
IMAGE_NAMESPACE="registry.gitlab.com/etalab/data.gouv.fr/infra"
IMAGE_NAME="docker-ansible-git-crypt"
IMAGE_VERSION="python3.12.11-ansible10.5.0-docker28.4.0-$(git rev-parse --short HEAD)"

docker build -t $IMAGE_NAMESPACE/$IMAGE_NAME:$IMAGE_VERSION .
docker push $IMAGE_NAMESPACE/$IMAGE_NAME:$IMAGE_VERSION

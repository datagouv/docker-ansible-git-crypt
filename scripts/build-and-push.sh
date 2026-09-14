#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DOCKER_DEFAULT_PLATFORM="linux/amd64"
IMAGE_NAMESPACE="3776n4y0.gra7.container-registry.ovh.net/datagouv_infra"
IMAGE_NAME="docker-ansible-git-crypt"
IMAGE_VERSION="python3.12.13-ansible13.6.0-docker28.4.0-$(git rev-parse --short HEAD)"

docker build -t $IMAGE_NAMESPACE/$IMAGE_NAME:$IMAGE_VERSION .
docker push $IMAGE_NAMESPACE/$IMAGE_NAME:$IMAGE_VERSION

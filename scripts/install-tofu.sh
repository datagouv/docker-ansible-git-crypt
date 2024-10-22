#!/bin/bash

TOFU_VERSION="$1"

wget https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_amd64.apk
apk add --allow-untrusted tofu_${TOFU_VERSION}_amd64.apk

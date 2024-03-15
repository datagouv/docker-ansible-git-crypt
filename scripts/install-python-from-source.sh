#!/bin/bash

PYTHON_VERSION="$1"

wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
tar -xf Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION} && \
./configure --enable-optimizations
make && make install
rm -rf Python-${PYTHON_VERSION} Python-${PYTHON_VERSION}.tgz

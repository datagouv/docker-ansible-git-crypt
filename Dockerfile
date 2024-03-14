FROM docker:25.0.3-alpine3.19

LABEL org.label-schema.vcs-url="https://github.com/etalab/docker-ansible-git-crypt" \
      org.label-schema.schema-version="1.0"

ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PYTHON_VERSION=3.12.2

COPY requirements.txt /opt/requirements.txt

# install apk dependencies
RUN apk update -q
RUN apk add --no-cache build-base && \
    apk add --no-cache zlib-dev && \
    apk add --no-cache openssl-dev && \
    apk add --no-cache libffi-dev && \
    apk add --no-cache openssh && \
    apk add --no-cache git && \
    apk add --no-cache git-crypt && \
    apk add --no-cache gnupg && \
    apk add --no-cache bash
RUN apk cache clean

# install Python from source
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make && make install
RUN rm -rf Python-${PYTHON_VERSION} Python-${PYTHON_VERSION}.tgz

# install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install -r /opt/requirements.txt

RUN install -d -m 700 /root/.ssh

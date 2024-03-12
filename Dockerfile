FROM docker:25.0.3-alpine3.19

LABEL org.label-schema.vcs-url="https://github.com/etalab/docker-ansible-git-crypt" \
      org.label-schema.schema-version="1.0"

ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PYTHON_VERSION=3.12.2

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
    pip3 install ansible-lint==6.22.0 && \
    pip3 install ansible==8.6.1 && \
    pip3 install flake8==6.1.0 && \
    pip3 install invoke==2.2.0 && \
    pip3 install jmespath==1.0.1 && \
    pip3 install mkdocs==1.5.3 && \
    pip3 install netaddr==0.9.0 && \
    pip3 install ovh==1.1.0 && \
    pip3 install passlib==1.7.4 && \
    pip3 install requests==2.31.0 && \
    pip3 install openstacksdk==3.0.0 && \
    pip3 install python-nomad==2.0.0 && \
    pip3 install docker==6.1.3

RUN install -d -m 700 /root/.ssh

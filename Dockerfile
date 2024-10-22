FROM docker:27.3.1-alpine3.20

LABEL org.label-schema.vcs-url="https://github.com/datagouv/docker-ansible-git-crypt" \
      org.label-schema.schema-version="1.0"

ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PYTHON_VERSION=3.12.2
ENV TOFU_VERSION=1.8.3

COPY apk-packages.txt requirements.txt scripts/install-python-from-source.sh scripts/install-tofu.sh /opt/

# install apk dependencies
RUN apk update -q
RUN xargs -a /opt/apk-packages.txt apk add --no-cache

# install Python from source
RUN /opt/install-python-from-source.sh $PYTHON_VERSION

# install tofu
RUN /opt/install-tofu.sh $TOFU_VERSION

# install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir -r /opt/requirements.txt

# remove files
RUN rm /opt/*

RUN install -d -m 700 /root/.ssh

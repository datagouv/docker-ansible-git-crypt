FROM docker:25.0.3-alpine3.19

LABEL org.label-schema.vcs-url="https://github.com/datagouv/docker-ansible-git-crypt" \
      org.label-schema.schema-version="1.0"

ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PYTHON_VERSION=3.12.2

COPY apk-packages.txt requirements.txt scripts/install-python-from-source.sh /opt/

# install apk dependencies
RUN apk update -q
RUN xargs -a /opt/apk-packages.txt apk add --no-cache

# install Python from source
RUN /opt/install-python-from-source.sh $PYTHON_VERSION

# install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir -r /opt/requirements.txt

# remove files
RUN rm /opt/*

RUN install -d -m 700 /root/.ssh

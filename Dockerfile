FROM python:3.10-bullseye

LABEL org.label-schema.vcs-url="https://github.com/etalab/docker-ansible-git-crypt" \
      org.label-schema.schema-version="1.0"

RUN apt update -q
RUN apt install --yes --no-install-suggests --no-install-recommends openssh-client
RUN apt install --yes --no-install-suggests --no-install-recommends git
RUN apt install --yes --no-install-suggests --no-install-recommends git-crypt
RUN apt install --yes --no-install-suggests --no-install-recommends gnupg2
RUN apt install --yes --no-install-suggests --no-install-recommends python3-pip
RUN apt install --yes --no-install-suggests --no-install-recommends python3-setuptools
RUN apt clean

RUN pip3 install --upgrade pip
RUN pip3 install ansible-lint==4.1.0
RUN pip3 install ansible==7.3.0
RUN pip3 install flake8==3.7.5
RUN pip3 install invoke==1.2.0
RUN pip3 install jmespath==0.9.3
RUN pip3 install mkdocs==1.0.4
RUN pip3 install netaddr==0.8.0
RUN pip3 install ovh==1.0.0
RUN pip3 install passlib==1.7.1
RUN pip3 install requests==2.28.1
RUN pip3 install openstacksdk==0.61.0
RUN pip3 install python-nomad==1.4.1
RUN pip3 install docker==6.0.0

RUN install -d -m 700 /root/.ssh

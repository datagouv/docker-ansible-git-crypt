Ansible docker image with support for ssh and gpg keys

This facilitates the use of playbooks backed by a git-crypt-based
repository.

Build image:
```
$ ./scripts/build-and-push.sh
```

Example of how to use this docker image in GitLab CI with a git-crypt'ed
repository:

```yaml
---
stages:
  - ansible

before_script:
  # add ssh config
  - echo -e "${ANSIBLE_SSH_CONFIG}" > ~/.ssh/config
  # run ssh-agent and add ssh key to it
  - eval $(ssh-agent -s)
  - echo -e "${SSH_PRIVATE_KEY}" | tr -d '\r' | ssh-add -
  # add gpg key to keyring
  - echo -e "${GPG_PRIVATE_KEY}" | gpg2 --import --batch
  - echo -e "${GPG_OWNERTRUST}" | gpg2 --import-ownertrust
  # run gpg-agent in allow-preset-passphrase mode
  - gpgconf --kill gpg-agent || true
  - gpg-agent --daemon --allow-preset-passphrase --max-cache-ttl 3600
  # set gpg passphrase
  - /usr/lib/gnupg2/gpg-preset-passphrase --preset --passphrase "${GPG_PASSPHRASE}" "${GPG_PUBLIC_KEYGRIP}"
  # unlock the current repository
  - git crypt unlock

playbook:
  stage: ansible
  image: sdelafond/docker-ansible-git-crypt:latest
  script:
    - ansible-playbook sites/foo.yml
```

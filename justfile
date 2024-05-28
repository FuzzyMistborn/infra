export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

# Recipes
@default:
  just --list

### Run/Builds
build_adonalsium:
	ansible-playbook -u root -b run.yml --limit adonalsium --ask-pass

build_ishap:
	ansible-playbook -u root -b run.yml --limit ishap --ask-pass

build_virtuosity:
	ansible-playbook -u geoff -b run.yml --limit virtuosity --ask-pass  --ask-become-pass

build +HOST:
	ansible-playbook -b run.yml --limit {{ HOST }}

### Updates
update:
	ansible-playbook update.yml

docker:
	ansible-playbook docker.yml

test:
	ansible-playbook -b test.yml

### Vault
decrypt:
	ansible-vault decrypt vars/vault.yaml

encrypt:
	ansible-vault encrypt vars/vault.yaml

### Lint
yamllint:
    yamllint -s .

ansible-lint: yamllint
    #!/usr/bin/env bash
    ansible-lint .
    ansible-playbook run.yml update.yml bootstrap.yml docker.yml --syntax-check

### Bootstrap/Setup
bootstrap_lxc:
	ansible-playbook -b bootstrap.yml --limit lxc ambition

bootstrap +HOST:
	ansible-playbook -b bootstrap.yml --limit {{ HOST }} --ask-pass --ask-become-pass

install:
	@./prereqs.sh
	@echo "Ansible Vault pre-hook script setup and vault password set"

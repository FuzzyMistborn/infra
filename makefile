### Run/Builds
build:
	ansible-playbook -b run.yml --limit ${host}

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

### Setup
proxmox:
	ansible-playbook -u root -b run.yml --limit adonalsium --ask-pass

bootstrap_lxc:
	ansible-playbook -b bootstrap.yml --limit lxc ambition

bootstrap_desktop:
	ansible-playbook -b bootstrap.yml --limit ${host} --ask-pass --ask-become-pass

bootstrap_unity:
	ansible-playbook -b bootstrap.yml --limit unity --ask-pass --ask-become-pass

git:
	@./gitupdate.sh

install:
	@./prereqs.sh
	@echo "Ansible Vault pre-hook script setup and vault password set"

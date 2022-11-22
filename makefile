### Shard Plays

dominion:
	ansible-playbook -b run.yml --limit dominion

endowment:
	ansible-playbook -b run.yml --limit endowment

autonomy:
	ansible-playbook -b run.yml --limit autonomy

cultivation:
	ansible-playbook -b run.yml --limit cultivation

preservation:
	ansible-playbook -b run.yml --limit preservation

honor:
	ansible-playbook -b run.yml --limit honor

valor:
	ansible-playbook -b run.yml --limit valor

unity:
	ansible-playbook -b run.yml --limit unity

omada:
	ansible-playbook -b run.yml --limit omada

ambition:
	ansible-playbook -b run.yml --limit ambition

drone:
	ansible-playbook -b run.yml --limit drone

retroarchtv:
	ansible-playbook -b run.yml --limit retroarch_tv

kelsier:
	ansible-playbook -b run.yml --limit kelsier

hoid:
	ansible-playbook -b run.yml --limit hoid

adonalsium:
	ansible-playbook -b run.yml --limit adonalsium

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

bootstrap_kelsier:
	ansible-playbook -b bootstrap.yml --limit kelsier --ask-pass --ask-become-pass

bootstrap_hoid:
	ansible-playbook -b bootstrap.yml --limit hoid --ask-pass --ask-become-pass

bootstrap_unity:
	ansible-playbook -b bootstrap.yml --limit unity --ask-pass --ask-become-pass

bootstrap_retroarchtv:
	ansible-playbook -b bootstrap.yml --limit retroarch_tv --ask-pass --ask-become-pass

git:
	@./gitupdate.sh

install:
	@./prereqs.sh
	@echo "Ansible Vault pre-hook script setup and vault password set"

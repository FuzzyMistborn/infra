### Shard Plays

dominion:
	ansible-playbook -b run.yml --limit dominion --vault-password-file .vault-password

endowment:
	ansible-playbook -b run.yml --limit endowment --vault-password-file .vault-password

autonomy:
	ansible-playbook -b run.yml --limit autonomy --vault-password-file .vault-password

cultivation:
	ansible-playbook -b run.yml --limit cultivation --vault-password-file .vault-password

preservation:
	ansible-playbook -b run.yml --limit preservation --vault-password-file .vault-password

honor:
	ansible-playbook -b run.yml --limit honor --vault-password-file .vault-password

valor:
	ansible-playbook -b run.yml --limit valor --vault-password-file .vault-password

mercy:
	ansible-playbook -b run.yml --limit mercy --vault-password-file .vault-password

omada:
	ansible-playbook -b run.yml --limit omada --vault-password-file .vault-password

ambition:
	ansible-playbook -b run.yml --limit ambition --vault-password-file .vault-password

drone:
	ansible-playbook -b run.yml --limit drone --vault-password-file .vault-password

retroarchtv:
	ansible-playbook -b run.yml --limit retroarch_tv --vault-password-file .vault-password

hyperion:
	ansible-playbook -b run.yml --limit hyperion --vault-password-file .vault-password

kelsier:
	ansible-playbook -b run.yml --limit kelsier --vault-password-file .vault-password

adonalsium:
	ansible-playbook -b run.yml --limit adonalsium --vault-password-file .vault-password

### Updates
update:
	ansible-playbook update.yml --vault-password-file .vault-password

docker:
	ansible-playbook docker.yml --vault-password-file .vault-password

test:
	ansible-playbook -b test.yml --vault-password-file .vault-password

### Vault
decrypt:
	ansible-vault decrypt --vault-password-file .vault-password vars/vault.yaml

encrypt:
	ansible-vault encrypt --vault-password-file .vault-password vars/vault.yaml

### Setup
proxmox:
	ansible-playbook -u root -b run.yml --limit adonalsium --ask-pass --vault-password-file .vault-password

odium:
	ansible-playbook -u root -b run.yml --limit odium --ask-pass --vault-password-file .vault-password

bootstrap_lxc:
	ansible-playbook -b bootstrap.yml --limit lxc ambition --vault-password-file .vault-password

bootstrap_kelsier:
	ansible-playbook -b bootstrap.yml --limit kelsier --ask-pass --ask-become-pass --vault-password-file .vault-password

bootstrap_retroarchtv:
	ansible-playbook -b bootstrap.yml --limit retroarch_tv --ask-pass --ask-become-pass --vault-password-file .vault-password

bootstrap_hyperion:
	ansible-playbook -b bootstrap.yml --ask-pass --limit hyperion --vault-password-file .vault-password

git:
	@./gitupdate.sh

install:
	@./prereqs.sh
	@echo "Ansible Vault pre-hook script setup and vault password set"

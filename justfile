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
	ansible-playbook -u root -b run.yml --limit virtuosity --ask-pass  --ask-become-pass

build +HOST:
	ansible-playbook -b run.yml --limit {{ HOST }}

### Updates
update:
	ansible-playbook update.yml

caddy +HOST:
    ansible-playbook -b caddy.yml --limit {{ HOST }}

test:
	ansible-playbook -b test.yml

### Docker
docker:
	ansible-playbook docker.yml

docker-changes HOST:
    @./container-changes.sh {{ HOST }}

docker-changes-all:
    #!/usr/bin/env bash
    echo "Checking all docker hosts..."
    for host in adonalsium endowment autonomy cultivation preservation omada honor unity ambition investiture invention identity virtuosity whimsy; do
        echo ""
        echo "========================================"
        echo "HOST: $host"
        echo "========================================"
        ./container-changes.sh "$host" || true
    done

docker-auto:
    ansible-playbook docker-auto.yml

docker-auto-host HOST:
    ansible-playbook docker-auto.yml -e "host={{ HOST }}" -e "auto_detect=yes"

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

bootstrap_vm +HOST:
	ansible-playbook -b bootstrap.yml --limit {{ HOST }} --ask-pass --ask-become-pass

bootstrap +HOST:
	ansible-playbook -b bootstrap.yml --limit {{ HOST }} --ask-pass --ask-become-pass

install:
	@./prereqs.sh
	@echo "Ansible Vault pre-hook script setup and vault password set"

### Git
# git submodule - repo URL + optional local folder name
add-submodule URL *NAME:
    #!/usr/bin/env sh
    if [ -z "{{NAME}}" ]; then
        # Extract repo name from URL if no name provided
        basename=$(basename "{{URL}}" .git)
        git submodule add {{URL}} "roles/${basename}"
        git submodule update --init --recursive
        git add .gitmodules "roles/${basename}"
        git commit -m "Adds ${basename} as a submodule"
    else
        git submodule add {{URL}} "roles/{{NAME}}"
        git submodule update --init --recursive
        git add .gitmodules "roles/{{NAME}}"
        git commit -m "Adds {{NAME}} as a submodule"
    fi

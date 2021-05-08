#!/bin/bash
green=$'\e[0;32m'
red=$'\e[0;31m'
reset=$'\e[0m'

if ( cat vars/vault.yaml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "${green}Vault Encrypted. Safe to commit.${reset}"
else
echo "${red}Vault not encrypted! Run 'make encrypt' and try again.${reset}"
exit 1
fi
read -p "Commit description: " desc
git add . && \
git add -u && \
git commit -m "$desc" && \
git push origin  main

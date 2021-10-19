#!/bin/bash
green=$'\e[0;32m'
red=$'\e[0;31m'
reset=$'\e[0m'

if ( cat $HOME/infra/vars/vault.yaml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "${green}Vault Encrypted. Safe to commit.${reset}"
else
echo "${red}Vault not encrypted! Run 'make encrypt' and try again.${reset}"
exit 1
fi
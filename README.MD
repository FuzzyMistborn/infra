# Introduction

This repo contains the code used to deploy and managing my various LXC's on Proxmox.  Ansible is the main way I deploy things.

A huge HUGE thanks to IronicBadger/AlexKTZ for his [infra GitHub repo](https://github.com/IronicBadger/infra).  I learned a ton poking around that repo and some of the things are copied straight from there, so credit where credit is due.

# First Deploy instructions:

`make install` - Installs a github hook to prevent uploading an unencrypted Ansible vault file, adds the Ansible Galaxy roles, and sets up the Ansible vault password

`make boostrap` - Sets up the hosts with a main user and an ansible user that can run sudo without a password

`make proxmox` - Creates all LXCs, sets up disks on Proxmox host

`make ____` - Sets up the various LXCs

# Ansible Vault

`make encrypt` - Encrypts the Ansible vault
`make decrypt` - Decrypts the Ansible vault

# Git

`make git` - Runs the gitupdate script

# Updates

`make update` - Runs apt update and apt upgrade on the servers, and pushes an updated docker-compose.yml file
`make docker` - Runs docker-compose pull {{containers}} and docker-compose up -d {{container}} on host and containers specified

### If you appreciate my work, please consider buying me a beer (or cofee, or whatever)
[![BuyMeCoffee][buymecoffee-shield]][buymecoffee-link]

[buymecoffee-link]: https://www.buymeacoffee.com/fuzzymistborn
[buymecoffee-shield]: https://cdn.buymeacoffee.com/buttons/v2/default-blue.png
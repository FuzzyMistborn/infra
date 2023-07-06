# Introduction

This repo contains the code used to deploy and managing my various LXC's on Proxmox.  Ansible is the main way I deploy things.

A huge HUGE thanks to IronicBadger/AlexKTZ for his [infra GitHub repo](https://github.com/IronicBadger/infra).  I learned a ton poking around that repo and some of the things are copied straight from there, so credit where credit is due.

## Requirements

- Python 3
- `ansible` installed on the system
- [`just`](https://github.com/casey/just)
    - Lazy install: `curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sudo bash -s -- --to /usr/local/bin`

# Explanation of Shards/Names:

Most of my servers are named after Shards of Adonalsium from my favorite fantasy series by Brandon Sanderson.  So if you look at my roles you'll see a pattern.

* **Adonalsium** - Primary Proxmox Node
* **Autonomy** - Home Automation
* **Cultivation** - Misc. Media
* **Dominion** - Ansible primary dev/git
* **Endowment** - Media distribution/collection
* **Honor** - DMZ/Primary Adguard/Wireguard
* **Preservation** - Databases
* **Ambition** - Cloud VPS

Then my desktops are named after some of my favorite characters from the Cosmere: Kelsier, Vasher, and Szeth.

# First Deploy instructions:

`just install` - Installs a github hook to prevent uploading an unencrypted Ansible vault file, adds the Ansible Galaxy roles, and sets up the Ansible vault password

`just boostrap` - Sets up the hosts with a main user and an ansible user that can run sudo without a password

`just build_proxmox` - Creates all LXCs, sets up disks on Proxmox host

`just bootstrap HOSTNAME` - Bootstraps the indicated server/desktop/whatever

`just build HOSTNAME` - Sets up the various machines

# Ansible Vault

`just encrypt` - Encrypts the Ansible vault
`just decrypt` - Decrypts the Ansible vault

# Updates

`just update` - Runs apt update and apt upgrade on the servers, and pushes an updated docker-compose.yml file
`just docker` - Runs docker-compose pull {{ containers }} and docker-compose up -d {{ container }} on host and containers specified

### If you appreciate my work, please consider buying me a beer (or coffee, or whatever)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/E1E5796VZ)

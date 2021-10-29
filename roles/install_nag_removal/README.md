# Proxmox Nag Removal Installer

An ansible role to install [pve-fake-subscription](https://github.com/Jamesits/pve-fake-subscription/).  I've tried many of the Proxmox nag removal tools out there, this one has been the most reliable.

## Features

- Installation of `pve-fake-subscription` deb package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `nag_force_install` defaults to `false`.  The purpose of that variable is to force an install to a specific version you pinned.

```yaml
nag_ver: v0.0.7
nag_force_install: false
```
Note that the `v` is necessary.
# LEGO Installer

An ansible role to install and configure [LEGO](https://go-acme.github.io/lego/).

## Features

- Installation of `lego` GO binary.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `lego_force_install` defaults to `false`.  The purpose of that variable is to force an install to a specific version you pinned.

```yaml
lego_ver: v4.4.0
lego_force_install: false
```
Note that the `v` is necessary.

## To Do
- Add cronjobs?
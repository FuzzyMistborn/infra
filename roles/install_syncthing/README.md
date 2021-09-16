# Syncthing Installer

An ansible role to install and configure [syncthing](https://www.syncthing.net).  Not 100% done yet and mostly untested.

## Features

- Installation of `syncthing` GO binary.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `syncthing_force_install` defaults to `false`. The purpose of that variable is to force an install to a specific version you pinned.  Warning: `syncthing_user` defaults to `root`!

```yaml
syncthing_ver: v1.18.2
syncthing_force_install: false
syncthing_user: pi
```
Note that the `v` is necessary.

## To Do
- Add way to configure config.xml file?
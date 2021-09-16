# Hugo Installer

An ansible role to install and configure [Hugo](https://gohugo.io/).

## Features

- Installation of `hugo` GO binary.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `hugo_force_install` defaults to `false`. The purpose of that variable is to force an install to a specific version you pinned.

```yaml
hugo_ver: v0.88.1
hugo_force_install: false
```
Note that the `v` is necessary.

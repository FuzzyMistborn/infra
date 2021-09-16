# MergerFS Installer

An ansible role to install [MergerFS](https://github.com/trapexit/mergerfs/), a union filesystem that I use in combination with Snapraid to create a simple, reliable  and redudant data store.  See [PerfectMediaServer](https://perfectmediaserver.com/tech-stack/mergerfs.html) for more information.

## Features

- Installation of `mergerfs` deb package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `mergerfs_force_install` defaults to `false`.  The purpose of that variable is to force an install to a specific version you pinned.

```yaml
mergerfs_ver: 2.32.6
mergerfs_force_install: false
```
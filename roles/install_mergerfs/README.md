# MergerFS Installer

An ansible role to install [MergerFS](https://github.com/trapexit/mergerfs/), a union filesystem that I use in combination with Snapraid to create a simple, reliable  and redudant data store.  See [PerfectMediaServer](https://perfectmediaserver.com/tech-stack/mergerfs.html) for more information.

## Features

- Installation of `mergerfs` deb package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.

```yaml
mergerfs_download_latest_ver: true  # Change to 'false' to pin to a specific version
mergerfs_pinned_ver: 2.32.6  # Overriden by 'mergerfs_download_latest_ver' variable
mergerfs_distro: debian-bullseye_amd64
```

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
mergerfs_download_latest_ver: false
mergerfs_pinned_ver: 2.32.6
```
By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.
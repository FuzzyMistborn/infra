# Hugo Installer

An ansible role to install and configure [Hugo](https://gohugo.io/).

## Features

- Installation of `hugo` GO binary.
- Updating if there is an update and version is not pinned.

## Configuration

This role has a number of variables that can be configured.

| Variable                            | Description                                              | Default           |
| ----------------------------------- | -------------------------------------------------------- | ----------------- |
| **hugo_download_latest_ver**        | Whether to download the latest version from Github.      | `true`
| **hugo_pinned_ver**                 | Desired version of Hugo (overriden by above var).        | `0.88.1`
| **hugo_distro**                     | Which distro to target for download.                     | `Linux-64bit`
| **hugo_install_directory**          | Where to install Hugo binary.                            | `/usr/local/bin`

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
hugo_download_latest_ver: false
hugo_pinned_ver: 0.88.1
```
By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.

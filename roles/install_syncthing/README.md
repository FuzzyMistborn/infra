# Syncthing Installer

An ansible role to install and configure [syncthing](https://www.syncthing.net).

Credit for some of the config regex goes to https://github.com/escaped/ansible-syncthing/

## Features

- Installation of `syncthing` GO binary.
- Updating if there is an update and version is not pinned.
- Configure basic config settings.

## Configuration

This role has a number of variables that can be configured.

| Variable                            | Description                                              | Default           |
| ----------------------------------- | -------------------------------------------------------- | ----------------- |
| **syncthing_download_latest_ver**   | Whether to download the latest version from Github.      | `true`
| **syncthing_pinned_ver**            | Desired version of syncthing (overriden by above var).   | `1.18.3`
| **syncthing_distro**                | Which distro to target for download.                     | `linux_amd64`
| **syncthing_install_directory**     | Where to install Syncthing binary.                       | `/usr/bin`
| **syncthing_user**                  | User to install binary.  **SHOULD BE CHANGED!**          | `root`
| **syncthing_webinterface_ip**       | IP:Port for webinterface.                                | `0.0.0.0:8080`
| **syncthing_localannounce**         | enable/disable localAnnounce.                            | `true`
| **syncthing_globalannounce**        | enable/disable globaleAnnounce.                          | `false`
| **syncthing_remove_default_folder** | Removes the default folder at /home/user/Sync            | `true`

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
syncthing_download_latest_ver: false
syncthing_pinned_ver: 1.18.3
```
By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.

## To Do
- ~~Add way to configure config.xml file?~~
- Add user/password configuration option
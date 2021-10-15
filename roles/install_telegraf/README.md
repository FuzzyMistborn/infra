# Telegraf Installer

An ansible role to install and configure [Telegraf](https://github.com/influxdata/telegraf/).  Not 100% done yet and mostly untested.

## Features

- Installation of `Telegraf` package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  There are a few default variables you must change: `telegraf_influx_token` and `telegraf_influx_bucket`.  You can obtain these from your influx install.  Optionally, you can configure `telegraf_influx_pve_api` if you run Proxmox.

```yaml
telegraf_download_latest_ver: true  # Change to 'false' to pin to a specific version
telegraf_pinned_ver: 1.20.2  # Overriden by 'telegraf_download_latest_ver' variable
telegraf_distro: amd64

telegraf_config_path: "/etc/telegraf"
telegraf_config_user: root
telegraf_config_group: root

telegraf_influx_url: 'http://localhost:8086'
telegraf_influx_token: change_me
telegraf_influx_org: Influx
telegraf_influx_bucket: change_me
telegraf_influx_disk_mounts: '"/"'
telegraf_influx_docker: false
telegraf_influx_pve: false
telegraf_influx_pve_api: change_me
```

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
telegraf_download_latest_ver: false
telegraf_pinned_ver: 1.20.2
```
By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.
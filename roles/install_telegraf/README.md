# Telegraf Installer

An ansible role to install and configure [Telegraf](https://github.com/influxdata/telegraf/).  Not 100% done yet and mostly untested.

## Features

- Installation of `Telegraf` package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `telegraf_force_install` defaults to `false`. The purpose of that variable is to force an install to a specific version you pinned.

There are a few default variables you must change: `telegraf_influx_token` and `telegraf_influx_bucket`.  You can obtain these from your influx install.  Optionally, you can configure `telegraf_influx_pve_api` if you run Proxmox.

```yaml
telegraf_ver: 1.19.3
telegraf_force_install: false

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

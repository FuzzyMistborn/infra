# Telegraf Installer

An ansible role to install and configure [Telegraf](https://github.com/influxdata/telegraf/).  Not 100% done yet and mostly untested.

## Features

- Installation of `Telegraf` package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `telegraf_force_install` defaults to `false`. The purpose of that variable is to force an install to a specific version you pinned.

```yaml
telegraf_ver: 1.19.3
telegraf_force_install: false
```

## To Do
- Add way to set up configuration
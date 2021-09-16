# Runitor Installer

An ansible role to install and configure [Runitor](https://github.com/bdd/runitor), a tool for simpler configuration and setup of your Healthchecks.io cronjobs.

## Features

- Installation of `runitor` GO binary, as well as sets the API-URL as an environmental variable.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `runitor_force_install` defaults to `false`.  The purpose of that variable is to force an install to a specific version you pinned.  You can modify the `runitor_url` to your own self-hosted HealtChecks instance if you run one, otherwise the default is to the HealthChecks.io site.

```yaml
runitor_ver: v0.8.0
runitor_force_install: false
runitor_url: https://hc.example.com
```
Note that the `v` is necessary.
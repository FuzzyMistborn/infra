# Proxmox Nag Removal Installer

An ansible role to install [pve-fake-subscription](https://github.com/Jamesits/pve-fake-subscription/).  I've tried many of the Proxmox nag removal tools out there, this one has been the most reliable.

## Features

- Installation of `pve-fake-subscription` deb package.
- Updating if there is an update and version is not pinned.

## Configuration

Below are the configurable variables.  Note that `nag_force_install` defaults to `false`.  The purpose of that variable is to force an install to a specific version you pinned.

```yaml
nag_ver: v0.0.7
nag_force_install: false
```
Note that the `v` is necessary.

## Github API

This role utilizes the GitHub API to determine the latest release available.  By default, the role utilizes unauthenticated requests, which are [limited by GitHub](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting) to 60 requests per hour.  Requests are associated with the originating IP address.  For most usecases, this is not an issue.  However, you may find yourself rate limited.  If you authenticate, you can make 5,000 requests per hour.

To authenticate, you must obtain a [Personal Access Token](https://github.com/settings/tokens/new).  The token does not need any scopes selected.  Then add the following variables:

```
github_api_user: fuzzymistborn
github_api_pass: YOUR_TOKEN
github_api_auth: yes
```

That's it!
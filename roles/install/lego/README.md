# LEGO Installer

An ansible role to install and configure [LEGO](https://go-acme.github.io/lego/).

## Features

- Installation of `lego` GO binary.
- Updating if there is an update and version is not pinned.

## Configuration

This role has a number of variables that can be configured.

| Variable                            | Description                                              | Default           |
| ----------------------------------- | -------------------------------------------------------- | ----------------- |
| **lego_download_latest_ver**        | Whether to download the latest version from Github.      | `true`
| **lego_pinned_ver**                 | Desired version of LEGO (overriden by above var).        | `4.5.3`
| **lego_distro**                     | Which distro to target for download.                     | `linux_amd64`
| **lego_install_directory**          | Where to install LEGO binary.                            | `/usr/local/bin`

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
lego_download_latest_ver: false
lego_pinned_ver: 4.5.2
```
By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.

## Github API

This role utilizes the GitHub API to determine the latest release available.  By default, the role utilizes unauthenticated requests, which are [limited by GitHub](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting) to 60 requests per hour.  Requests are associated with the originating IP address.  For most usecases, this is not an issue.  However, you may find yourself rate limited.  If you authenticate, you can make 5,000 requests per hour.

To authenticate, you must obtain a [Personal Access Token](https://github.com/settings/tokens/new).  The token does not need any scopes selected.  Then add the following variables:

```
github_api_user: fuzzymistborn
github_api_pass: YOUR_TOKEN
github_api_auth: yes
```

That's it!

## To Do
- Add cronjobs?
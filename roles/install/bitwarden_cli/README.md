# Bitwarden CLI Installer

An ansible role to install and configure [Bitwarden CLI](https://bitwarden.com/help/article/cli/).

## Features

- Installation of `BW` binary.
- Updating if there is an update and version is not pinned.

## Configuration

This role has a number of variables that can be configured.

| Variable                            | Description                                              | Default           |
| ----------------------------------- | -------------------------------------------------------- | ----------------- |
| **bwo_download_latest_ver**        | Whether to download the latest version from Github.      | `true`
| **bw_pinned_ver**                 | Desired version of BW CLI (overriden by above var).        | `1.20.0`
| **bw_distro**                     | Which distro to target for download.                     | `linux`
| **bw_install_directory**          | Where to install BW CLI binary.                            | `/usr/local/bin`

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
bw_download_latest_ver: false
bw_pinned_ver: 1.20.0
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

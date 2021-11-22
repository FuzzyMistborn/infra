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

## Github API

This role utilizes the GitHub API to determine the latest release available.  By default, the role utilizes unauthenticated requests, which are [limited by GitHub](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting) to 60 requests per hour.  Requests are associated with the originating IP address.  For most usecases, this is not an issue.  However, you may find yourself rate limited.  If you authenticate, you can make 5,000 requests per hour.

To authenticate, you must obtain a [Personal Access Token](https://github.com/settings/tokens/new).  The token does not need any scopes selected.  Then add the following variables:

```
github_api_user: fuzzymistborn
github_api_pass: YOUR_TOKEN
github_api_auth: yes
```

That's it!
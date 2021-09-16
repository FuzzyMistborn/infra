# Autorestic/Restic Installer

An ansible role to install and configure [restic](https://github.com/restic/restic) and [autorestic](https://github.com/cupcakearmy/autorestic).  Inspiration/basis for the role goes to [@IronicBadger](https://github.com/IronicBadger/infra/tree/master/roles/ktz-autorestic)

## Features

- Installation and configuration of `restic` and `autorestic` GO binaries.
- Copying/updating `autorestic` config file.
- Updating binaries if there is an update and version is not pinned.

## Configuration

This role has a few variables that can be configured.  Main ones to consider relate to the `autorestic` config file.  

Additionally, you can pin a specific version of either binary with `autorestic_ver` or `restic_ver`.  By default the role fetches and installs the latest available version, and will run the update command if the binary is already present every time the role is run.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
autorestic_ver: v1.2.0
restic_ver: v0.12.1
```
Note that the `v` is necessary.  Currently, it's not possible to pin a version of `restic` when upgrading `autorestic` because the upgrade command for `autorestic` upgrades both binaries.  If you want to disable both, you'll need to pin a version of `autorestic` as well.

### Example for Autorestic Config File

Below is an example that shows all the available options.

```yaml
autorestic_locations:
  - name: docker
    from: '/opt/docker'
    to: 
      - synology_docker
      - b2_docker
    cron: "'0 3 * * 0'"
    hooks:
      before:
        - echo "before"
      after:
        - echo "after"
        - echo "after2"
      success:
        - echo "success"
      failure:
        - echo "failure"
    options:
        backup:
          tag:
            - foo
            - bar
          exclude:
            - '*.log'
          excludefile: 
            - .gitignore
        forget:
          last: 3
          hourly: 1
          daily: 10
          weekly: 2
          monthly: 1
          yearly: 2
          within: 10
  - name: home
    from: '/home/user1'
    to: 
      - synology_docker
autorestic_backends:
  - name: synology_docker
    type: s3
    path: "http://192.168.1.10:9000/docker"
    key: some-random-password-134893987987134
    env:
      - "AWS_ACCESS_KEY_ID: YOUR_AWS_KEY_ID"
      - "AWS_SECRET_ACCESS_KEY: YOUR_AWS_KEY"
    options:
        backup:
          tag:
            - foo
            - bar
          exclude:
            - '*.log'
          excludefile: 
            - .gitignore
        forget:
          last: 3
          weekly: 2
          within: 10
  - name: b2_docker
    type: b2
    path: "B2_BUCKET_NAME:/docker"
    key: some-random-password-134893987987134
    env:
      - "B2_ACCOUNT_ID: accountid"
      - "B2_Account_Key: accountkey"
```
For additional documentation, please see the [official docs](https://autorestic.vercel.app/).  Also please open an issue if there is a setting/configuration option that is missing.  I believe I got them all, though I may be missing a few I don't use.

## To Do

- Add cronjob variables (?) for basic tasks (backup, forget, etc).  Or add support for 
- Switch to variable for distro (ie for file extension)
- Find a way to pin restic even if updating autorestic
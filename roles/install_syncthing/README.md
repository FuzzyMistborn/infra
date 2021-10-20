# Syncthing Installer

An ansible role to install and configure [syncthing](https://www.syncthing.net).

Credit for the config template to https://gitlab.com/veenj/ansible-syncthing/

## Features

- Installation of `syncthing` GO binary.
- Updating if there is an update and version is not pinned.
- Copy configuration template based on variables

## Configuration

This role has a number of variables that can be configured.

| Variable                            | Description                                              | Default           |
| ----------------------------------- | -------------------------------------------------------- | ----------------- |
| **syncthing_download_latest_ver**   | Whether to download the latest version from Github.      | `true`
| **syncthing_pinned_ver**            | Desired version of syncthing (overriden by above var).   | `1.18.3`
| **syncthing_distro**                | Which distro to target for download.                     | `linux_amd64`
| **syncthing_install_directory**     | Where to install Syncthing binary.                       | `/usr/bin`
| **syncthing_user**                  | User to install binary.  **SHOULD BE CHANGED!**          | `root`
| **syncthing_webinterface_ip**       | IP:Port for webinterface.                                | `0.0.0.0:8384`
| **syncthing_localannounce**         | enable/disable localAnnounce.                            | `true`
| **syncthing_globalannounce**        | enable/disable globaleAnnounce.                          | `false`
| **syncthing_api_key**               | API Key to use REST API                                  | `Optional`
| **syncthing_gui_authentication**    | Whether to enable user/password for GUI.                 | `false`


### Installation

By default the role fetches and installs the latest available version.  You can disable this by pinning to a specific version.  Here's an example if you wanted to set the version.

```yaml
syncthing_download_latest_ver: false
syncthing_pinned_ver: 1.18.3
```
By setting a pinned version, a version will only be pulled if the installed version does not match the pinned version.

### Config.xml

Below is an example variable set that you can set per host/group.  An API key is optional if you want to use the REST API.  I create mine manually in a disposable VM by starting syncthing, copying the generated key, stopping syncthing and deleting the config.xml file.  Rinse and repeat.

```yaml
syncthing_api_key: TV6e2UNAwPiokJvro8Qf4NN3dhSvtyVj
syncthing_gui_authentication: true
syncthing_gui_user: syncthing
syncthing_gui_pass: $2a$12$fgHJda57iMiSC0dazGhLreitG7tpQzSirZYRaLcUQF.vI8tpWfVzC # change_me in bcrypt

syncthing_folders:
  - id: "cpxh2-fva5j"
    label: "test"
    path: "/my/custom/path"
    type: "sendreceive" # options are 'sendreceive' 'sendonly' and 'receiveonly'
    rescanInterval: 600 # time in seconds
    devices:
      - GG5EYTT-CULJPYQ-BACDTDU-NYUITOO-55YO6FA-JJHESUG-VKY4ZYI-HQWEAQY
      - PJ6H6RG-LD654U4-KIOYQOY-VG4QL2Q-LZCGD7T-DZNOZIX-32M7Z7Y-3MEXMA3

syncthing_devices:
 - id: GG5EYTT-CULJPYQ-BACDTDU-NYUITOO-55YO6FA-JJHESUG-VKY4ZYI-HQWEAQY
   name: test
   address: tcp://192.168.1.2:22000 # defaults to dynamic
 - id: PJ6H6RG-LD654U4-KIOYQOY-VG4QL2Q-LZCGD7T-DZNOZIX-32M7Z7Y-3MEXMA3
   name: test2
   address: tcp://192.168.1.2:22000 # defaults to dynamic
```
## To Do
- ~~Add way to configure config.xml file?~~
- Add user/password configuration option
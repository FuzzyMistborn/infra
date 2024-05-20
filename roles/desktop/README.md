# Desktop Notes

Things I can't ansible but want to remember:
- Enable SSH
    - `sudo systemctl enable --now sshd`
- Wake On Lan
    - https://wiki.archlinux.org/title/Wake-on-LAN#Enable_WoL_on_the_network_adapter
    - `nmcli con show` and then `nmcli c show "Wired connection 1" | grep 802-3-ethernet.wake-on-lan`
        - Finally `nmcli c modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic`
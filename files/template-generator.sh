#!/bin/bash

cd /var/lib/vz/template/iso

wget https://releases.ubuntu.com/20.04.2/ubuntu-20.04.2-live-server-amd64.iso

wget https://mirrors.nycbug.org/pub/opnsense/releases/21.1/OPNsense-21.1-OpenSSL-dvd-amd64.iso.bz2

tar -xf OPNsense-21.1-OpenSSL-dvd-amd64.iso.bz2

rm OPNsense-21.1-OpenSSL-dvd-amd64.iso.bz2

qm create 9000 --name "ubuntu-template" --memory 2048 --net0 virtio,bridge=vmbr0

qm importdisk 9000 ubuntu-20.04.2-live-server-amd64.iso local-lvm

qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0

qm set 9000 --boot c --bootdisk scsi0

qm set 9000 --serial0 socket --vga serial0

qm template 9000

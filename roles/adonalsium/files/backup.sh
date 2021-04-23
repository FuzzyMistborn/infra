#!/bin/bash
# Mount HDD
mount -t ntfs /dev/disk/by-uuid/26967030966FFF1D /media/external_hdd

# Wait for mount
sleep 5s

# rsync script
rsync -Aavx --progress --delete --exclude 'UHD' --exclude 'Parents *' --exclude 'Kids TV' /mnt/Media/ /media/external_hdd/Media
rsync -Aavx --progress --delete --exclude 'Coppermind' --exclude 'Kelsier' /mnt/Backup/ /media/external_hdd/Backup

# Wait for dismount
sleep 10s

# Unmount HDD
umount /media/external_hdd
echo "Backup Complete!"
echo
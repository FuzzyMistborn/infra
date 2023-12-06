#!/bin/bash
# Mount HDD
mount /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_9MGWV2JJ-part1 /media/external_hdd
mount /mnt/synology_backup
mount /mnt/synology_restic

# Wait for mount
sleep 10s

# rsync script
rsync -Aavx --progress --delete --exclude '.*' --exclude 'TV Shows' --exclude 'Parents *' --exclude 'Frigate' /mnt/Media/ /media/external_hdd/Media
rsync -Aavx --progress --delete --exclude '.*' --exclude '#recycle' /mnt/synology_backup/ /media/external_hdd/Backup
rsync -Aavx --progress --delete --exclude '.*' --exclude 'media' /mnt/synology_restic/ /media/external_hdd/Restic

# Wait for dismount
sleep 10s

# Unmount HDD
umount /media/external_hdd
umount /mnt/synology_backup
umount /mnt/synology_restic
echo "Backup Complete!"

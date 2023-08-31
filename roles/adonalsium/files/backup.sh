#!/bin/bash
# Mount HDD
mount /dev/disk/by-uuid/54622b56-2601-4404-a519-2546242b0b42 /media/external_hdd
mount /mnt/synology_backup
mount /mnt/synology_restic

# Wait for mount
sleep 10s

# rsync script
rsync -Aavx --progress --delete --exclude '.*' --exclude 'TV Shows' --exclude 'Parents *' --exclude 'UHD' --exclude 'Frigate' --exclude 'Files/arch' /mnt/Media/ /media/external_hdd/Media
rsync -Aavx --progress --delete --exclude '.*' --exclude '#recycle' /mnt/synology_backup/ /media/external_hdd/Backup
rsync -Aavx --progress --delete --exclude '.*' --exclude 'media' /mnt/synology_restic/ /media/external_hdd/Minio

# Wait for dismount
sleep 10s

# Unmount HDD
umount /media/external_hdd
umount /mnt/synology_backup
umount /mnt/synology_restic
echo "Backup Complete!"

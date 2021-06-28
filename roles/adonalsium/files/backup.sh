#!/bin/bash
# Mount HDD
mount -t ntfs /dev/disk/by-uuid/26967030966FFF1D /media/external_hdd
mount /mnt/synology_backup
mount /mnt/synology_minio

# Wait for mount
sleep 10s

# rsync script
rsync -Aavx --progress --delete --exclude '.*' --exclude 'TV Shows' --exclude 'Parents *' --exclude 'UHD' /mnt/Media/ /media/external_hdd/Media
rsync -Aavx --progress --delete --exclude '.*' --exclude '#recycle' /mnt/synology_backup/ /media/external_hdd/Backup
rsync -Aavx --progress --delete --exclude '.*' --exclude 'media' /mnt/synology_minio/ /media/external_hdd/Minio

# Wait for dismount
sleep 10s

# Unmount HDD
umount /media/external_hdd
umount /mnt/synology_backup
umount /mnt/synology_minio 
echo "Backup Complete!"

#!/bin/bash
# Mount HDD
mount /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_9MGWV2JJ-part1 /media/external_hdd
mount /mnt/local_backup

# Wait for mount
sleep 10s

# rsync script
rsync -Aavx --info=progress2 --delete --delete-excluded --exclude '.*' --exclude '.trickplay' --exclude 'TV Shows' --exclude 'Parents *' --exclude 'UHD' --exclude 'Frigate' --exclude 'Immich' /mnt/Media/ /media/external_hdd/Media
rsync -Aavx --info=progress2 --delete --delete-excluded --exclude '.*' --exclude '.snapraid.content' /mnt/local_backup/ /media/external_hdd/Backup

df -h | tee disk_usage.txt

# Wait for dismount
sleep 10s

# Unmount HDD
umount /media/external_hdd
umount /mnt/local_backup
echo "Backup Complete!"

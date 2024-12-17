#!/bin/bash
# Mount HDD
mount /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_9MGWV2JJ-part1 /media/external_hdd
mount /mnt/local_backup

# Wait for mount
sleep 10s

# rsync script
rsync -Aavx --progress --delete --exclude '.*' --exclude 'TV Shows' --exclude 'Parents *' --exclud 'UHD' --exclude 'Frigate' --exclude 'Immich' /mnt/Media/ /media/external_hdd/Media
rsync -Aavx --progress --delete --exclude '.*' --exclude '.snapraid.content' /mnt/local_backup/ /media/external_hdd/Backup

# Wait for dismount
sleep 10s

# Unmount HDD
umount /media/external_hdd
umount /mnt/local_backup
echo "Backup Complete!"

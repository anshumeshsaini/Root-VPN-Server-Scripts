#!/bin/bash
# VPN Configuration Backup Script

BACKUP_DIR="/home/$USER/vpn-backups"
DATE=$(date '+%Y%m%d-%H%M%S')
BACKUP_FILE="vpn-backup-$DATE.tar.gz"

mkdir -p $BACKUP_DIR

# Create backup
sudo tar -czf "$BACKUP_DIR/$BACKUP_FILE" \
    /etc/wireguard/ \
    /etc/openvpn/ \
    /etc/ufw/ \
    /etc/ssh/sshd_config \
    2>/dev/null

# Keep only last 10 backups
cd $BACKUP_DIR
ls -t vpn-backup-*.tar.gz | tail -n +11 | xargs rm -f

echo "Backup created: $BACKUP_FILE"
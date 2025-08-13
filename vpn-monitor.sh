#!/bin/bash
# VPN Monitoring Script

LOG_FILE="/var/log/vpn-monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Check WireGuard status
if systemctl is-active --quiet wg-quick@wg0; then
    echo "[$DATE] WireGuard: ACTIVE" >> $LOG_FILE
else
    echo "[$DATE] WireGuard: INACTIVE - Restarting..." >> $LOG_FILE
    sudo systemctl restart wg-quick@wg0
fi

# Check for failed login attempts
FAILED_LOGINS=$(grep "Failed password" /var/log/auth.log | grep "$(date '+%b %d')" | wc -l)
if [ $FAILED_LOGINS -gt 10 ]; then
    echo "[$DATE] WARNING: $FAILED_LOGINS failed login attempts today" >> $LOG_FILE
fi

# Check bandwidth usage
RX_BYTES=$(cat /sys/class/net/wg0/statistics/rx_bytes 2>/dev/null || echo 0)
TX_BYTES=$(cat /sys/class/net/wg0/statistics/tx_bytes 2>/dev/null || echo 0)
echo "[$DATE] Bandwidth: RX=$(($RX_BYTES/1024/1024))MB TX=$(($TX_BYTES/1024/1024))MB" >> $LOG_FILE
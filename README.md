# VPN Server Setup Scripts

This package contains automated scripts to help you set up your own VPN server.

## Included Scripts

### 1. wireguard-setup.sh
Automatically installs and configures WireGuard VPN server.
Usage: `chmod +x wireguard-setup.sh && ./wireguard-setup.sh`

### 2. add-client.sh
Generates new client configurations for WireGuard.
Usage: `chmod +x add-client.sh && ./add-client.sh [client-name]`

### 3. openvpn-install.sh
Downloads and runs the OpenVPN road warrior installer.
Usage: `chmod +x openvpn-install.sh && ./openvpn-install.sh`

### 4. firewall-setup.sh
Configures UFW firewall with appropriate VPN rules.
Usage: `chmod +x firewall-setup.sh && ./firewall-setup.sh`

### 5. vpn-monitor.sh
Monitors VPN status and logs activity.
Usage: Add to crontab: `*/5 * * * * /path/to/vpn-monitor.sh`

### 6. backup-config.sh
Creates backups of VPN configurations.
Usage: Add to crontab: `0 2 * * 0 /path/to/backup-config.sh`

## Prerequisites

- Ubuntu 20.04+ or Debian 10+
- Root access (sudo)
- Internet connection

## Security Notes

- Always change default passwords
- Keep your system updated: `sudo apt update && sudo apt upgrade`
- Monitor your server logs regularly
- Use strong authentication methods



# 🔐 VPN Server Setup Scripts

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Shell Script](https://img.shields.io/badge/Shell%20Scripts-Bash-blue.svg)]()
[![Ubuntu/Debian](https://img.shields.io/badge/OS-Ubuntu%20%7C%20Debian-orange.svg)]()
[![Security](https://img.shields.io/badge/Security-Hardened-red.svg)]()

> A collection of automated **Bash scripts** to quickly deploy, configure, and maintain your own VPN server with **WireGuard** and **OpenVPN**.

---

## 📑 Table of Contents
- [Overview](#-overview)
- [Included Scripts](#-included-scripts)
- [Prerequisites](#-prerequisites)
- [Installation & Usage](#-installation--usage)
- [Security Recommendations](#-security-recommendations)
- [Automation Examples](#-automation-examples)
- [Backup & Restore](#-backup--restore)
- [License](#-license)

---

##  Overview
This toolkit allows you to **set up a secure VPN server** in minutes.  
Whether you're hosting on a VPS or a dedicated server, these scripts take care of:
- VPN server installation (**WireGuard** / **OpenVPN**)
- Client configuration generation
- Firewall rule setup
- VPN monitoring & logging
- Automated backups

---

## 📜 Included Scripts

| Script Name          | Description |
|----------------------|-------------|
| **`wireguard-setup.sh`** | Installs and configures a WireGuard VPN server |
| **`add-client.sh`** | Generates new WireGuard client configuration files |
| **`openvpn-install.sh`** | Installs and configures OpenVPN server |
| **`firewall-setup.sh`** | Configures UFW firewall for VPN |
| **`vpn-monitor.sh`** | Monitors VPN connections and logs activity |
| **`backup-config.sh`** | Creates backups of VPN configuration files |

---

## 📦 Prerequisites
Before running these scripts, ensure:
- **Ubuntu 20.04+** or **Debian 10+**
- **Root (sudo) access**
- **Active internet connection**
- `curl`, `wget`, and `ufw` installed

---

## ⚙ Installation & Usage

### 1️⃣ WireGuard Setup
```bash
chmod +x wireguard-setup.sh
./wireguard-setup.sh


chmod +x add-client.sh
./add-client.sh [client-name]

3️⃣ OpenVPN Setup
chmod +x openvpn-install.sh
./openvpn-install.sh

4️⃣ Firewall Rules
chmod +x firewall-setup.sh
./firewall-setup.sh

5️⃣ Monitor VPN Activity (cron)
*/5 * * * * /path/to/vpn-monitor.sh

6️⃣ Backup Configurations (cron)
0 2 * * 0 /path/to/backup-config.sh

🔒 Security Recommendations
-> Change all default passwords immediately.
->> Keep your server updated:
sudo apt update && sudo apt upgrade -y

->Use SSH key authentication instead of passwords.
-> Regularly check logs:
journalctl -u wg-quick@wg0 --no-pager


🤖 Automation Examples
You can combine these scripts for fully automated deployment:
#!/bin/bash
./wireguard-setup.sh
./firewall-setup.sh
./add-client.sh client1
./backup-config.sh

💾 Backup & Restore
All configuration backups are stored in /etc/vpn-backups/ by default.

To restore:
sudo tar -xvzf backup-YYYY-MM-DD.tar.gz -C /



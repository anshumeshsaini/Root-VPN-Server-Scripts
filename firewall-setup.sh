#!/bin/bash
# UFW Firewall Configuration

sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (change port if using non-standard)
sudo ufw allow 22/tcp

# Allow WireGuard
sudo ufw allow 51820/udp

# Allow OpenVPN (if using)
sudo ufw allow 1194/udp

# Enable firewall
sudo ufw --force enable

# Verify rules
sudo ufw status verbose
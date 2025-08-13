#!/bin/bash
# WireGuard VPN Server Auto-Setup Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}WireGuard VPN Server Auto-Setup${NC}"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}This script should not be run as root${NC}" 
   exit 1
fi

# Install WireGuard
echo -e "${YELLOW}Installing WireGuard...${NC}"
sudo apt update
sudo apt install wireguard -y

# Generate keys
echo -e "${YELLOW}Generating server keys...${NC}"
cd /etc/wireguard/
sudo umask 077
sudo wg genkey | sudo tee server_private_key | sudo wg pubkey | sudo tee server_public_key

# Get server IP
SERVER_IP=$(curl -s ipinfo.io/ip)
echo -e "${GREEN}Server IP: $SERVER_IP${NC}"

# Create server config
echo -e "${YELLOW}Creating server configuration...${NC}"
sudo tee /etc/wireguard/wg0.conf << EOF
[Interface]
PrivateKey = $(sudo cat server_private_key)
Address = 10.0.0.1/24
ListenPort = 51820
SaveConfig = true
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
EOF

# Enable IP forwarding
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Start WireGuard
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0

echo -e "${GREEN}WireGuard setup complete!${NC}"
echo -e "${YELLOW}Server Public Key:${NC} $(sudo cat server_public_key)"
echo -e "${YELLOW}Server IP:${NC} $SERVER_IP"
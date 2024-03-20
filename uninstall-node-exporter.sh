#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo or log in as the root user."
    exit 1
fi

# Hardcoded node_exporter version
node_exporter_version="1.7.0"

# Stop and disable node_exporter service
echo "Stopping and disabling node_exporter service..."
systemctl stop node_exporter.service
systemctl disable node_exporter.service

# Remove node_exporter service file
echo "Removing node_exporter service file..."
rm -f /etc/systemd/system/node_exporter.service

# Reload systemd
echo "Reloading systemd..."
systemctl daemon-reload

# Remove node_exporter binary
echo "Removing node_exporter binary..."
rm -f /usr/local/bin/node_exporter

# Remove the node_exporter user
echo "Removing the node_exporter user..."
userdel -r node_exporter

# Remove UFW rule
# Note: This command assumes that the UFW rule added by the original script is the only rule allowing access from the specified IP to port 9100.
echo "Removing UFW rule for node_exporter..."
ufw delete allow from 103.127.133.15 to any port 9100 comment 'Allow Prometheus server to access node exporter'

echo "node_exporter removal complete."

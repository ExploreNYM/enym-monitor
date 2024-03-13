#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo or log in as the root user."
    exit 1
fi

# Hardcoded node_exporter version
node_exporter_version="1.7.0"
prometheus_ip="103.127.133.15"

# Create a user for node_exporter without a home directory
useradd --no-create-home --shell /bin/false node_exporter

# Download node_exporter
echo "Downloading node_exporter version $node_exporter_version..."
wget "https://github.com/prometheus/node_exporter/releases/download/v$node_exporter_version/node_exporter-$node_exporter_version.linux-amd64.tar.gz" -O /tmp/node_exporter-$node_exporter_version.linux-amd64.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download node_exporter."
    exit 1
fi

# Unarchive node_exporter
echo "Unarchiving node_exporter..."
tar xvfz /tmp/node_exporter-$node_exporter_version.linux-amd64.tar.gz -C /tmp
if [ $? -ne 0 ]; then
    echo "Failed to unarchive node_exporter."
    exit 1
fi

# Move node_exporter to /usr/local/bin
echo "Moving node_exporter to /usr/local/bin..."
mv /tmp/node_exporter-$node_exporter_version.linux-amd64/node_exporter /usr/local/bin/node_exporter
if [ $? -ne 0 ]; then
    echo "Failed to move node_exporter."
    exit 1
fi

# Set ownership and permissions
chown node_exporter:node_exporter /usr/local/bin/node_exporter
chmod 0755 /usr/local/bin/node_exporter

# Create node_exporter service file
echo "Creating node_exporter service file..."
cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start node_exporter service
echo "Configuring systemd for node_exporter..."
systemctl daemon-reload
systemctl enable node_exporter.service
systemctl start node_exporter.service

# Add UFW rule
echo "Configuring UFW to allow traffic from $prometheus_ip to node_exporter..."
ufw allow from $prometheus_ip to any port 9100 comment 'Allow Prometheus server to access node exporter'

# Cleanup
echo "Cleaning up..."
rm -rf /tmp/node_exporter-${node_exporter_version}.linux-amd64.tar.gz
rm -rf /tmp/node_exporter-${node_exporter_version}.linux-amd64

echo "node_exporter installation and configuration complete."
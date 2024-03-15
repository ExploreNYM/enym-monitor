# ExploreNYM Monitoring Service

This repository contains scripts to help you sign up and set up the ExploreNYM monitoring service for your system. This service allows you to monitor your system's metrics using Prometheus and visualize them through a Grafana dashboard hosted at https://monitor.explorenym.net.

## Prerequisites

Before starting, ensure you have:

- A system running Debian/Ubuntu or a compatible distribution.
- Root or sudo privileges to install necessary packages and execute scripts.

## Getting Started

Follow these steps to set up your system for the ExploreNYM monitoring service.

### 1. Install Git

First, install Git, which is required to clone the repository containing the necessary setup scripts.

```sh
apt install git
```

### 2. Clone the Repository

Clone the repository to download the setup scripts to your system.

```sh
git clone https://github.com/ExploreNYM/enym-monitor ~/enym-monitor
```

### 3. Setup Node Exporter

Run the following script to install Node Exporter, which collects system metrics to be sent to the ExploreNYM monitoring service.

```sh
chmod +x ~/enym-monitor/node-exporter.sh && ~/enym-monitor/node-exporter.sh
```

### 4. Register for the Grafana Dashboard

Execute the following script to register your system with the ExploreNYM monitoring service and gain access to your Grafana dashboard.

```sh
chmod +x ~/enym-monitor/enym-monitor.sh && ~/enym-monitor/enym-monitor.sh
```

After running this script, you should receive information on how to access your Grafana dashboard.

## Verifying the Installation

Ensure that the Node Exporter is running correctly on your system:

```sh
systemctl status node_exporter
```

You should also confirm that you have received access details for your Grafana dashboard after executing the `enym-monitor.sh` script.

## Troubleshooting

If you encounter any issues during the setup process, ensure you have internet connectivity and the necessary permissions to execute the scripts. Check the script logs for specific error messages, and verify that all dependencies were installed successfully.

## Need Help?

For additional support or if you have any questions, please contact @pawnflake:matrix.org or open an issue in this repository.
```

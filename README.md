# ExploreNYM Monitoring Service

This repository contains scripts to help you sign up and set up the ExploreNYM monitoring service for your system. By following these instructions, you will install Node Exporter on your system to collect system metrics, and you'll register to view these metrics through a Grafana dashboard hosted at https://monitor.explorenym.net.

## Prerequisites

Before starting, ensure you have:

- A system running Debian/Ubuntu or a compatible distribution.
- Root or sudo privileges to install necessary packages and execute scripts.

## Disclaimer

By using the ExploreNYM monitoring service, please be aware that the data from your personal dashboard will be visible to the ExploreNYM team and the Nym QA team. This service is recommended for Network test events and for individuals who cannot provision their own monitoring stack. If you have concerns about sharing specific data or need a private monitoring solution, consider setting up a personal instance of Prometheus and Grafana. (https://github.com/ExploreNYM/self-hosted-monitor)

## Getting Started

These steps will guide you through setting up your system with the ExploreNYM monitoring service.

### 1. Install Git

Git is a version control system required to clone the repository containing the setup scripts. To install Git, execute the following command:

```sh
apt install git
```

If you're unsure whether Git is installed, you can check by running `git --version`. If Git is installed, this command will return the version number.

### 2. Clone the Repository

Cloning the repository downloads the necessary setup scripts to your system. Run the following command to clone the ExploreNYM monitoring service repository:

```sh
git clone https://github.com/ExploreNYM/enym-monitor ~/enym-monitor
```

This command clones the repository into the `enym-monitor` directory in your home folder. If the clone is successful, you should see the directory populated with the repository's contents.

### 3. Setup Node Exporter

Node Exporter is a Prometheus exporter that collects system metrics for monitoring. To install and configure Node Exporter, run the script provided in the repository:

```sh
chmod +x ~/enym-monitor/node-exporter.sh && ~/enym-monitor/node-exporter.sh
```

This command makes the `node-exporter.sh` script executable and then executes it. The script will install Node Exporter and set it up to start automatically.

### 4. Register for the Grafana Dashboard

To register your system with the ExploreNYM monitoring service and access your Grafana dashboard, execute the following script:

```sh
chmod +x ~/enym-monitor/enym-monitor.sh && ~/enym-monitor/enym-monitor.sh
```

This script will register your system and provide you with information on how to access your Grafana dashboard to view your system's metrics.

## Verifying the Installation

After installing Node Exporter, you can check its status to ensure it's running correctly:

```sh
systemctl status node_exporter
```

If Node Exporter is active and running, the installation process was successful. Additionally, after executing the `enym-monitor.sh` script, make sure you receive the information necessary to access your Grafana dashboard.

## Troubleshooting

If you encounter any issues during the setup process, ensure you have internet connectivity and the necessary permissions to execute the scripts. Check the script logs for specific error messages, and verify that all dependencies were installed successfully.

## Need Help?

For additional support or if you have any questions, please contact @pawnflake:matrix.org or open an issue in this repository.

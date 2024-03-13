# enym-monitor
Explorenym provided monitoring service.

#### Install git
```sh
apt install git
```
#### clone the repo
```sh
git clone https://github.com/ExploreNYM/vps-monitor ~/vps-monitor
```

#### SETUP NODE-EXPORTER

```sh
chmod +x ~/vps-monitor/node-exporter.sh && ~/vps-monitor/node-exporter.sh
```
#### REGISTER GRAFANA DASHBOARD

```sh
chmod +x ~/vps-monitor/enym-monitor.sh && ~/vps-monitor/enym-monitor.sh
```

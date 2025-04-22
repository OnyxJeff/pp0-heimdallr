# Heimdallr

![Build](https://github.com/OnyxJeff/Heimdallr/actions/workflows/build.yml/badge.svg)
![Maintained](https://img.shields.io/badge/maintained-yes-blue)

**Heimdallr** stands watch over my homelab from the modest hardware of a Pi Zero.

It runs:
- A **Power-on-Server script** to boot sleeping devices and ping key IPs and log their status to a file or local dashboard on command.
- An **Auto Update script** to keep your OS updated.

---

## 📁 Repo Structure

```text
heimdallr/
├── .github/workflows/    # CI for YAML validation
├── scripts/              # Wake-on-LAN & Uptime logger scripts
└── README.md             # You're reading it!
```

---

## 🚀 Deployment

---

## 🧰 Services

| HassOS              | Home Assistant OS                          |
| :---                | :---:                                      |
| Wake-on-LAN         | Script that wakes up devices               |
| Uptime Logger       | Script that logs uptime of devices         |

### ⚡ Wake-on-LAN/Uptime Logger

To wake a device add your MAC addresses and IP addresses into the script:

```bash
bash scripts/power-on-server.sh
```
This will also pings your critical devices every 45 minutes if you schedule this via cron:

```bash
# Wake-on-LAN        
    45 * * * * bash /home/${USER}/power-on-server.sh >> /home/${USER}/logs/power-on-server.log
        # run "power-on-server.sh" every hour at *:45 am/pm
    30 0 * * 1 /bin/bash -c 'find /home/${USER}/logs -name "power-on-server.log" -exec sh -c "cp {} /home/${USER}/backup_logs/\$(date +\%Y\%m\%d)-\$(basename {})" \; -exec rm {} \;'
        # saves weekly version of "power-on-server.log" on Monday of every week at 00:30 am then deletes the old log
```

Log output is stored in logs/power-on-server.log and backup_logs/power-on-server.log or can be adapted to report to an API or dashboard.

### 🕒 Auto Updater

This script will update, upgrade, and clean up:

```bash
bash scripts/apt-get-autoupdater.sh
```

To auto update your device, schedule this via cron:

```bash
# OS-Auto-Updater
    5 2 * * 0 bash /home/${USER}/apt-get-autoupdater.sh >> /home/${USER}/logs/apt-get-autoupdater.log
        # execute automatic update script and log every sunday at 02:05 am
    1 0 1 * * /bin/bash -c 'find /home/${USER}/logs -name "apt-get-autoupdater.log" -exec sh -c "cp {} /home/${USER}/backup_logs/\$(date +\%Y\%m\%d)-\$(basename {})" \; -exec rm {} \;'
        # saves monthly version of "apt-get-autoupdater.log" on the 1st of every month at 00:01 am then deletes the old log
```

Log output is stored in logs/apt-get-autoupdater.log and backup_logs/apt-get-autoupdater.log or can be adapted to report to an API or dashboard.

---

📬 Maintained By
Jeff M. • [@OnyxJeff](https://www.github.com/onyxjeff)
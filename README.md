# Heimdallr

![Build](https://github.com/OnyxJeff/Heimdallr/actions/workflows/build.yml/badge.svg)
![Maintained](https://img.shields.io/badge/maintained-yes-blue)

**Heimdallr** stands watch over my homelab from the modest hardware of a Pi Zero.

It runs:
- A **Wake-on-LAN script** to boot sleeping devices on command.
- An **uptime logging script** to ping key IPs and log their status to a file or local dashboard.

---

## ⚡ Wake-on-LAN

To wake a device (add your MAC addresses into the script):

```bash
bash scripts/wake-on-lan.sh <device-nickname>
```

---

## 🕒 Uptime Logger
To ping your critical devices every 5 minutes, schedule this via cron:

```bash
bash scripts/uptime-logger.sh
```
Log output is stored in logs/uptime.log or can be adapted to report to an API or dashboard.

---

📬 Maintained By
Jeff M. • [@OnyxJeff](https://www.github.com/onyxjeff)
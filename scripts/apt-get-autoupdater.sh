#!/bin/bash
#
# run
# sudo crontab -e
# 5 2 * * 0 bash /home/${USER}/apt-get-autoupdater.sh >> /home/${USER}/logs/apt-get-autoupdater.log 
    # execute automatic update script and log every sunday at 02:05 am
# 0 0 1 * * root cp /home/${USER}/logs/apt-get-autoupdater.log /home/${USER}/backups_logs/apt-get-autoupdater-'date +\%Y\%m\%d'.log 
    # saves monthly version of "apt-get-autoupdater.log" on the 1st of every month at 00:00 am
# 1 0 1 * 0 root find /home/${USER}/logs/apt-get-autoupdater.log -type f -delete   
    # deletes "apt-get-autoupdater.log" on the 1st of every month at 00:01 am
# apt-get update script for cron automatization
# This script is released under the BSD 3-Clause License.

echo
echo "############################"
echo "Starting apt-get-autoupdater"
date
echo
apt-get update
apt-get --fix-broken install
apt-get --yes upgrade
apt-get autoremove
apt-get clean
apt-get autoclean
exit 0
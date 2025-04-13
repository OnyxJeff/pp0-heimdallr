# !/bin/bash
# this runs as a @hourly cron task
# run
# crontab -e
# @hourly bash /home/pi/power-on-server.sh > power-on-server.log
# requires etherwake and wakeonlan (apt-get)
# installed etherwake and wakeonlan beacuse I had some issues with one or the other between updates, so >
# run Wake-on-LAN from rpi_cronjob_examples.txt
echo
echo "############################"
echo "Starting power-on-server"
date
echo

HOSTNUM=0
HOSTS=(
    192.168.1.1   # yggdrasil (Router)
    192.168.1.7   # Gladsheim (Pi-NAS [OMV])
    192.168.1.8   # Muninn (TrueNAS Scale)
    192.168.1.10  # Muninn (TrueNAS Scale)
    192.168.1.14  # Aesir1 (Vital Services Cluster - Aesir 1)
    192.168.1.17  # PotentPi1 (PotentPi 1 [PiHole & PiVPN])
    192.168.1.18  # PotentPi2 (PotentPi 2 [Internal Dashboard & Unifi Controller])
    192.168.1.19  # PotentPi3 (PotentPi 3 [Transmission Server])
    192.168.1.20  # PotentPi4 (PotentPi 4 [Minecraft Server])
    192.168.1.21  # PotentPi5 (PotentPi 5 [Home Assistant])
)
HOSTSDOWN=0
MACADDRS=(
    38:f7:cd:c1:e3:cc # 192.168.1.1
    dc:a6:32:dc:46:2b # 192.168.1.7
    ac:1f:6b:b2:0d:9e # 192.168.1.8
    ac:1f:6b:b2:0d:9f # 192.168.1.10
    f4:4d:30:6d:40:ab # 192.168.1.14
    e4:5f:01:67:86:e6 # 192.168.1.17
    e4:5f:01:0a:99:5c # 192.168.1.18
    dc:a6:32:d4:70:25 # 192.168.1.19
    dc:a6:32:d3:cc:dc # 192.168.1.20
    e4:5f:01:1a:7f:02 # 192.168.1.21
)
PING="/bin/ping -q -c1"
WAITTIME=10

### functions

function wake_up() {
  echo wakeonlan ${MACADDRS[${HOSTNUM}]}
  echo wakeonlan -p 9 ${MACADDRS[${HOSTNUM}]}
  echo sudo etherwake ${MACADDRS[${HOSTNUM}]}
}

# first sleep to allow system to connect to network and time to break out if needed
# sleep 60

for HOST in ${HOSTS[*]}; do
  if ! ${PING} ${HOST} > /dev/null
  then
    HOSTSDOWN=$((${HOSTSDOWN}+1))
    echo "${HOST} is down $(date)"
    # try to wake
    wake_up ${HOSTNUM}
    sleep 10
    wake_up ${HOSTNUM}
    sleep 10
    wake_up ${HOSTNUM}
    sleep 10
    wake_up ${HOSTNUM}
    sleep 10
    #restart networking
    /etc/init.d/networking reload
    sleep 15
    # try to wake
    wake_up ${HOSTNUM}
    sleep 2
    wake_up ${HOSTNUM}
    sleep 2
    HOSTNUM=$(($HOSTNUM+1))
  else
    echo "${HOST} was up at $(date)"
  fi
done

# reboot
if [[ ${HOSTSDOWN} -eq ${#HOSTS[@]} ]]
  then
  echo "Pi is rebooting"
fi
/sbin/shutdown -r now
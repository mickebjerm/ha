#!/bin/bash

SSH_USER="homeassistant"
SSH_HOST="router.local"
SSH_KEY="/config/.ssh/id_rsa"
DATE=`date '+%Y-%m-%d %H:%M:%S'`

if [ "$1" == "firewall" ]; then
    if [ ! "$2" ] ; then
        echo "ERROR: [ruletype] [${DATE}]" >> /config/firewall-kids.log
        exit 0
        if [ ! "$3" ] ; then
            echo "ERROR: [rulenumber] [${DATE}]" >> /config/firewall-kids.log
            exit 0
        fi
    else 
        echo "INFO: [${2} rule:${3}] [${DATE}] " >> /config/firewall-kids.log
        ssh -o stricthostkeychecking=no -i ${SSH_KEY} ${SSH_USER}@${SSH_HOST} -- "ip firewall filter ${2} numbers=${3}" >> /config/firewall-kids.log
        exit 0
    fi
else
    echo "ERROR: [firewall] [${DATE}]" >> /config/firewall-kids.log
    exit 0
fi


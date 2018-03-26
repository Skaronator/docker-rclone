#!/bin/sh

echo Hello World!

if [ ! -f "/config/.rclone.conf" ]
then
    echo "No config file found! Check Readme how to generate a config file!"
fi

echo $CRON_SCHEDULE


# start cron
# /usr/sbin/crond -f -l 8
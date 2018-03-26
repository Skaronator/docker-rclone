#!/bin/sh

echo "Starting rclone for Docker by Skaronator..."

if [ ! -f "/config/.rclone.conf" ]
then
  for run in {1..10}
  do
    echo "WARNING! No config file found! Check Readme how to generate a config file!"
  done
fi


echo "Um: $CRON_SCHEDULE"
echo "Um: $INIT_RUN"

if [ -n "${INIT_RUN}" ]; then
  echo "=> Create a backup on the startup"
  /run.sh
fi


# start cron
# /usr/sbin/crond -f -l 8
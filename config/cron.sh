#!/bin/bash

if [ -n "$1" ]; then
  args=("$@")
  argn=$#

  for i in $(seq $argn)
  do
    echo "${args[$i-1]}" >> /etc/cron.d/crontasks
  done
fi

cp /etc/cron.d/crontasks /tmp/temp.txt
chmod 600 /etc/cron.d/crontasks
crontab /etc/cron.d/crontasks

cron -f